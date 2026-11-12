#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/gts7fewifi

include device/samsung/sm7325-common/BoardConfigCommon.mk

# Partitions (PIT SM-T733, overrides Galaxy A52s values from sm7325-common)
BOARD_RECOVERYIMAGE_PARTITION_SIZE    := 101584896
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 69206016

# Kernel
TARGET_KERNEL_CONFIG        := vendor/lineage-gts7fewifi_defconfig \
                               vendor/mglru.config

# Kernel modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
RECOVERY_KERNEL_MODULES := $(BOARD_RECOVERY_RAMDISK_KERNEL_MODULES_LOAD)

# Recovery
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_RECOVERY_DEFAULT_ROTATION := ROTATION_RIGHT
TARGET_RECOVERY_DEFAULT_TOUCH_ROTATION := ROTATION_RIGHT

# Display
TARGET_SCREEN_DENSITY := 340

# OTA assert
TARGET_OTA_ASSERT_DEVICE := gts7fewifi

# Security patch
VENDOR_SECURITY_PATCH := 2025-06-01

# SePolicy
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/system_ext/private
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Properties
# product.prop replaces the sm7325-common copy (phone values, duplicate
# assignments with different values are a build error). Keep the rest in sync.
TARGET_PRODUCT_PROP := $(filter-out $(COMMON_PATH)/product.prop,$(TARGET_PRODUCT_PROP))
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
