@echo off

:: Create directories
mkdir lib\models
mkdir lib\repositories
mkdir lib\view_models
mkdir lib\views
mkdir lib\widgets
mkdir lib\services
mkdir lib\utils

:: Create files
type nul > lib\main.dart

:: Models
type nul > lib\models\player_model.dart
type nul > lib\models\sector_model.dart
type nul > lib\models\attendance_model.dart
type nul > lib\models\invoice_model.dart

:: Repositories
type nul > lib\repositories\player_repository.dart
type nul > lib\repositories\sector_repository.dart
type nul > lib\repositories\attendance_repository.dart
type nul > lib\repositories\invoice_repository.dart

:: View Models
type nul > lib\view_models\player_view_model.dart
type nul > lib\view_models\sector_view_model.dart
type nul > lib\view_models\attendance_view_model.dart
type nul > lib\view_models\invoice_view_model.dart

:: Views
type nul > lib\views\home_screen.dart
type nul > lib\views\add_player_screen.dart
type nul > lib\views\sector_details_screen.dart
type nul > lib\views\player_profile_screen.dart
type nul > lib\views\attendance_screen.dart
type nul > lib\views\invoice_screen.dart

:: Widgets
type nul > lib\widgets\player_card.dart
type nul > lib\widgets\sector_card.dart
type nul > lib\widgets\attendance_calendar.dart
type nul > lib\widgets\invoice_item.dart

:: Services
type nul > lib\services\firebase_service.dart
type nul > lib\services\qr_service.dart
type nul > lib\services\notification_service.dart

:: Utils
type nul > lib\utils\constants.dart
type nul > lib\utils\extensions.dart
type nul > lib\utils\helpers.dart

echo Project structure created successfully!