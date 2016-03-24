require 'pusher'

Pusher.app_id = '173328'
Pusher.key = 'e919433fb0319a339cd7'
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.logger = Rails.logger
Pusher.encrypted = true