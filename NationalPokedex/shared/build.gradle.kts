plugins {
    kotlin("multiplatform")
    kotlin("plugin.serialization") version "2.0.0"
    id("com.android.library")
}

@OptIn(org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi::class)
kotlin {
    targetHierarchy.default()

    androidTarget {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
        }
    }

    val coroutinesVersion = "1.7.1"
    val ktorVersion = "2.3.7"
    val dateTimeVersion = "0.4.0"

    sourceSets {
        commonMain.dependencies {
            implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$coroutinesVersion")
            implementation("io.ktor:ktor-client-core:$ktorVersion")
            implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
            implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
            implementation("io.ktor:ktor-client-logging:$ktorVersion")
            implementation("org.slf4j:slf4j-android:1.7.36")
            implementation("org.jetbrains.kotlinx:kotlinx-datetime:$dateTimeVersion")
        }

        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }

        // https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform-upgrade-app.html#add-more-dependencies
        // ktor-client-core共有モジュールの共通ソースセットにコア依存関係を追加する必要がある
        androidMain.dependencies {
            implementation("io.ktor:ktor-client-android:$ktorVersion")
        }

        iosMain.dependencies {
            implementation("io.ktor:ktor-client-darwin:$ktorVersion")
        }
    }
}

android {
    namespace = "com.akidon0000.nationalpokedex"
    compileSdk = 34
    defaultConfig {
        minSdk = 24
    }
}
