package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   
   public class PlayersPanelListItemState
   {
      
      public static const HIDDEN_RENDERER_STATE:uint = 0;
      
      public static const SHORT_RENDERER_STATE:uint = 1;
      
      public static const MEDIUM_TANK_RENDERER_STATE:uint = 2;
      
      public static const MEDIUM_PLAYER_RENDERER_STATE:uint = 4;
      
      public static const TINY_SHORT_STATE:uint = 5;
      
      public static const TINY_LONG_STATE:uint = 6;
      
      public static const SECOND_COLUMN_SHORT_RENDERER_STATE:uint = 7;
      
      public static const SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE:uint = 8;
      
      public static const SECOND_COLUMN_MEDIUM_PLAYER_RENDERER_STATE:uint = 9;
      
      public static const THIRD_COLUMN_SHORT_RENDERER_STATE:uint = 10;
      
      public static const THIRD_COLUMN_MEDIUM_TANK_RENDERER_STATE:uint = 11;
      
      public static const THIRD_COLUMN_MEDIUM_PLAYER_RENDERER_STATE:uint = 12;
      
      public static const SPECIAL_SECOND_COLUMN_TINY_SHORT_STATE:uint = 13;
      
      private static const SPEAK_ANIMATION_Y_OFFSET:uint = 5;
      
      private static const DEAD_BACKGROUND_X_OFFSET:uint = 1;
      
      private static const VEHICLE_ICON_FULLY_SCALED:uint = 100;
      
      private static const VEHICLE_ICON_TINY_SCALED:uint = 70;
      
      private static const VEHICLE_Y_TINY_OFFSET:uint = 10;
      
      private static const VEHICLE_Y_OFFSET:uint = 5;
      
      private static const SPEAK_ANIMATION_X_TINY_OFFSET:int = -32;
      
      private static const SPEAK_ANIMATION_X_SHORT_OFFSET:int = 13;
      
      private static const SPEAK_ANIMATION_X_OFFSET:uint = 82;
      
      private static const MUTE_X_FULL_OFFSET:uint = 82;
      
      private static const MUTE_X_SHORT_OFFSET:uint = 13;
      
      private static const DISABLE_COMMUNICATION_X_FULL_OFFSET:uint = 111;
      
      private static const DISABLE_COMMUNICATION_X_SHORT_OFFSET:uint = 42;
      
      private static const VEHICLE_X_TINY_OFFSET:uint = 0;
      
      private static const VEHICLE_X_SHORT_OFFSET:uint = 52;
      
      private static const VEHICLE_X_FULL_OFFSET:uint = 120;
      
      private static const HITBOX_TINY_WIDTH:uint = 56;
      
      private static const HITBOX_SHORT_WIDTH:uint = 132;
      
      private static const HITBOX_LONG_WIDTH:uint = 200;
      
      private static const DEAD_BACKGROUND_TINY_WIDTH:uint = 56;
      
      private static const DEAD_BACKGROUND_SHORT_WIDTH:uint = 132;
      
      private static const DEAD_BACKGROUND_LONG_WIDTH:uint = 200;
      
      private static const CHAT_COMMUNICATION_X_TINY_OFFSET:uint = 0;
      
      private static const CHAT_COMMUNICATION_X_SHORT_OFFSET:uint = 120;
      
      private static const CHAT_COMMUNICATION_X_MEDIUM_OFFSET:uint = 190;
      
      private static const CHAT_COMMUNICATION_Y_TINY_OFFSET:uint = 0;
      
      private static const CHAT_COMMUNICATION_Y_OFFSET:uint = 16;
      
      private static const X_SHORT_OFFSETS:Vector.<int> = new <int>[0,132,188];
      
      private static const X_LONG_OFFSETS:Vector.<int> = new <int>[0,200,256];
      
      private static const X_MOUSE_OVER_SECOND_OFFSETS:Vector.<int> = new <int>[0,56,256];
      
      private static const X_MOUSE_OVER_THIRD_OFFSETS:Vector.<int> = new <int>[0,56,112];
      
      public static const TINY_STATES:Vector.<uint> = new <uint>[TINY_SHORT_STATE,TINY_LONG_STATE,SPECIAL_SECOND_COLUMN_TINY_SHORT_STATE];
      
      public static const MEDIUM_STATES:Vector.<uint> = new <uint>[MEDIUM_TANK_RENDERER_STATE,MEDIUM_PLAYER_RENDERER_STATE,SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE,SECOND_COLUMN_MEDIUM_PLAYER_RENDERER_STATE,THIRD_COLUMN_MEDIUM_PLAYER_RENDERER_STATE,SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE,THIRD_COLUMN_MEDIUM_TANK_RENDERER_STATE];
      
      public static const SHORT_STATES:Vector.<uint> = new <uint>[SHORT_RENDERER_STATE,SECOND_COLUMN_SHORT_RENDERER_STATE,THIRD_COLUMN_SHORT_RENDERER_STATE];
       
      
      public function PlayersPanelListItemState()
      {
         super();
      }
      
      public static function transformToSingleColumnListItemState(param1:int, param2:uint) : uint
      {
         var _loc3_:uint = HIDDEN_RENDERER_STATE;
         if(param2 == 0)
         {
            if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_PLAYER || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER)
            {
               _loc3_ = MEDIUM_PLAYER_RENDERER_STATE;
            }
            else if(param1 == PLAYERS_PANEL_STATE.SHORT || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT)
            {
               _loc3_ = SHORT_RENDERER_STATE;
            }
            else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_SINGLE_COLUMN_MEDIUM_TANK || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK)
            {
               _loc3_ = MEDIUM_TANK_RENDERER_STATE;
            }
         }
         else if(param1 > PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN)
         {
            _loc3_ = param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS ? uint(TINY_SHORT_STATE) : uint(TINY_LONG_STATE);
         }
         return _loc3_;
      }
      
      public static function transformToMultiColumnListItemState(param1:int, param2:uint) : uint
      {
         var _loc3_:uint = HIDDEN_RENDERER_STATE;
         if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_SECOND_FOCUS && param2 == 1)
         {
            _loc3_ = SECOND_COLUMN_MEDIUM_PLAYER_RENDERER_STATE;
         }
         else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS && param2 == 1)
         {
            _loc3_ = SECOND_COLUMN_SHORT_RENDERER_STATE;
         }
         else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_SECOND_FOCUS && param2 == 1)
         {
            _loc3_ = SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE;
         }
         else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_THIRD_FOCUS && param2 == 2)
         {
            _loc3_ = THIRD_COLUMN_SHORT_RENDERER_STATE;
         }
         else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER_THIRD_FOCUS && param2 == 2)
         {
            _loc3_ = THIRD_COLUMN_MEDIUM_PLAYER_RENDERER_STATE;
         }
         else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK_THIRD_FOCUS && param2 == 2)
         {
            _loc3_ = THIRD_COLUMN_MEDIUM_TANK_RENDERER_STATE;
         }
         else if(param2 == 0)
         {
            _loc3_ = TINY_SHORT_STATE;
         }
         else if(param2 == 1)
         {
            if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT)
            {
               _loc3_ = TINY_SHORT_STATE;
            }
            else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER)
            {
               _loc3_ = TINY_LONG_STATE;
            }
            else
            {
               _loc3_ = SPECIAL_SECOND_COLUMN_TINY_SHORT_STATE;
            }
         }
         else if(param2 == 2)
         {
            if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT)
            {
               _loc3_ = TINY_SHORT_STATE;
            }
            else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_TANK || param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_MEDIUM_PLAYER)
            {
               _loc3_ = TINY_LONG_STATE;
            }
            else if(param1 == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_SHORT_SECOND_FOCUS)
            {
               _loc3_ = TINY_SHORT_STATE;
            }
            else
            {
               _loc3_ = TINY_LONG_STATE;
            }
         }
         return _loc3_;
      }
      
      public static function generateStateSettings(param1:uint, param2:uint) : PlayersPanelListItemSettings
      {
         var _loc3_:PlayersPanelListItemSettings = new PlayersPanelListItemSettings();
         _loc3_.speakAnimationY = SPEAK_ANIMATION_Y_OFFSET;
         _loc3_.deadBgX = DEAD_BACKGROUND_X_OFFSET;
         if(TINY_STATES.indexOf(param1) > -1)
         {
            _loc3_.vehicleIconXOffset = VEHICLE_X_TINY_OFFSET;
            _loc3_.vehicleIconYOffset = VEHICLE_Y_TINY_OFFSET;
            _loc3_.vehicleIconScale = VEHICLE_ICON_TINY_SCALED;
            _loc3_.speakAnimationX = SPEAK_ANIMATION_X_TINY_OFFSET;
            _loc3_.deadBgWidth = DEAD_BACKGROUND_TINY_WIDTH;
            _loc3_.hitWidth = HITBOX_TINY_WIDTH;
            _loc3_.chatCommunicationIconXOffset = CHAT_COMMUNICATION_X_TINY_OFFSET;
            _loc3_.chatCommunicationIconYOffset = CHAT_COMMUNICATION_Y_TINY_OFFSET;
            switch(param1)
            {
               case TINY_SHORT_STATE:
                  _loc3_.xPosition = X_SHORT_OFFSETS[param2];
                  break;
               case TINY_LONG_STATE:
                  _loc3_.xPosition = X_LONG_OFFSETS[param2];
                  break;
               case SPECIAL_SECOND_COLUMN_TINY_SHORT_STATE:
                  _loc3_.xPosition = X_MOUSE_OVER_SECOND_OFFSETS[param2];
            }
         }
         else if(MEDIUM_STATES.indexOf(param1) > -1)
         {
            _loc3_.vehicleIconXOffset = VEHICLE_X_FULL_OFFSET;
            _loc3_.vehicleIconYOffset = VEHICLE_Y_OFFSET;
            _loc3_.vehicleIconScale = VEHICLE_ICON_FULLY_SCALED;
            _loc3_.speakAnimationX = SPEAK_ANIMATION_X_OFFSET;
            _loc3_.deadBgWidth = DEAD_BACKGROUND_LONG_WIDTH;
            _loc3_.muteX = MUTE_X_FULL_OFFSET;
            _loc3_.disableCommX = DISABLE_COMMUNICATION_X_FULL_OFFSET;
            _loc3_.hitWidth = HITBOX_LONG_WIDTH;
            _loc3_.chatCommunicationIconXOffset = CHAT_COMMUNICATION_X_MEDIUM_OFFSET;
            _loc3_.chatCommunicationIconYOffset = CHAT_COMMUNICATION_Y_OFFSET;
            _loc3_.xPosition = 0;
            switch(param1)
            {
               case MEDIUM_TANK_RENDERER_STATE:
               case MEDIUM_PLAYER_RENDERER_STATE:
                  _loc3_.xPosition = 0;
                  break;
               case SECOND_COLUMN_MEDIUM_PLAYER_RENDERER_STATE:
               case SECOND_COLUMN_MEDIUM_TANK_RENDERER_STATE:
                  _loc3_.xPosition = X_MOUSE_OVER_SECOND_OFFSETS[param2];
                  break;
               case THIRD_COLUMN_MEDIUM_PLAYER_RENDERER_STATE:
               case THIRD_COLUMN_MEDIUM_TANK_RENDERER_STATE:
                  _loc3_.xPosition = X_MOUSE_OVER_THIRD_OFFSETS[param2];
            }
         }
         else if(SHORT_STATES.indexOf(param1) > -1)
         {
            _loc3_.vehicleIconXOffset = VEHICLE_X_SHORT_OFFSET;
            _loc3_.vehicleIconYOffset = VEHICLE_Y_OFFSET;
            _loc3_.vehicleIconScale = VEHICLE_ICON_FULLY_SCALED;
            _loc3_.speakAnimationX = SPEAK_ANIMATION_X_SHORT_OFFSET;
            _loc3_.deadBgWidth = DEAD_BACKGROUND_SHORT_WIDTH;
            _loc3_.muteX = MUTE_X_SHORT_OFFSET;
            _loc3_.disableCommX = DISABLE_COMMUNICATION_X_SHORT_OFFSET;
            _loc3_.hitWidth = HITBOX_SHORT_WIDTH;
            _loc3_.chatCommunicationIconXOffset = CHAT_COMMUNICATION_X_SHORT_OFFSET;
            _loc3_.chatCommunicationIconYOffset = CHAT_COMMUNICATION_Y_OFFSET;
            switch(param1)
            {
               case SHORT_RENDERER_STATE:
                  _loc3_.xPosition = 0;
                  break;
               case SECOND_COLUMN_SHORT_RENDERER_STATE:
                  _loc3_.xPosition = X_MOUSE_OVER_SECOND_OFFSETS[param2];
                  break;
               case THIRD_COLUMN_SHORT_RENDERER_STATE:
                  _loc3_.xPosition = X_MOUSE_OVER_THIRD_OFFSETS[param2];
            }
         }
         return _loc3_;
      }
   }
}
