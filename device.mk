#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_IS_TABLET := true

# call the common setup
$(call inherit-product, device/samsung/sm7325-common/common.mk)

# call the proprietary setup
$(call inherit-product, vendor/samsung/gts7fewifi/gts7fewifi-vendor.mk)

# Overlay
PRODUCT_PACKAGES += \
    FrameworksResDevice \
    Launcher3ResDevice \
    SettingsProviderResDevice \
    SystemUIResDevice \
    WifiResDevice

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Dalvik heap: 4 GB RAM, use the AOSP 4 GB value instead of the 6 GB
# profile inherited from sm7325-common (256m). Keep in sync with
# init.gts7fewifi.rc (lcd_density 640 override).
PRODUCT_VENDOR_PROPERTIES += \
    dalvik.vm.heapgrowthlimit=192m

# Rest of the AOSP 4 GB profile (frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)
# instead of the 6 GB values (16m / 0.5 / 32m).
PRODUCT_VENDOR_PROPERTIES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heaptargetutilization=0.6 \
    dalvik.vm.heapmaxfree=16m

# LMKD
# Disable watermark-based LOW_MEM kills (lmkd only uses them for
# lowmem_min_oom_score <= 1000). Kills then rely on PSI, swap and thrashing.
# Measured on 4 GB: cold starts 13.4 -> 0.2 of 24, kills -60 %, PSI full +16 %.
PRODUCT_VENDOR_PROPERTIES += \
    ro.lmk.lowmem_min_oom_score=1001

# Init files
PRODUCT_PACKAGES += \
    init.gts7fewifi.rc \
    wifi_firmware.rc

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    $(LOCAL_PATH)/configs/audio/audio_platform_info_diff.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info_diff.xml \

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/display_id_4630947232161729154.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630947232161729154.xml

# Input configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/sec_e-pen.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/sec_e-pen.idc \
    $(LOCAL_PATH)/configs/idc/Vendor_04e8_Product_a035.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/Vendor_04e8_Product_a035.idc \
    $(LOCAL_PATH)/configs/keylayout/Vendor_04e8_Product_a035.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_04e8_Product_a035.kl

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
