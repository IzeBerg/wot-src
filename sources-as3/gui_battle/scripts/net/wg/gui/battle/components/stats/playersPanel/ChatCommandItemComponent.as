package net.wg.gui.battle.components.stats.playersPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.stats.playersPanel.events.ChatCommandItemEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ChatCommandItemComponent extends MovieClip implements IDisposable
   {
      
      private static const OFFSET_TO_ANIMATION_WIDTH_SCALE:Number = 0.8;
      
      private static const DEFAULT_ANIMATION_WIDTH:int = 410;
      
      private static const SOURCE_ANIMATION_WIDTH:int = 200;
      
      private static const INVALID_INDEX:int = -1;
      
      private static const PLAYER_IS_ALLY_TARGET_STATE:String = "TARGET";
      
      private static const COMMAND_TARGET_STATE:String = "sos";
      
      private static const RED_STATE:String = "red";
      
      private static const ORANGE_STATE:String = "orange";
      
      private static const GREEN_STATE:String = "green";
      
      private static const PURPLE_STATE:String = "purple";
      
      private static const EMPTY_FRAME_STATE:String = "";
      
      private static const ATTACK_BASE_PURPLE_STATE:String = "attackBasePurple";
      
      private static const ATTACK_OBJECTIVE_PURPLE_STATE:String = "attackObjectivePurple";
      
      private static const ATTACK_PURPLE_STATE:String = "attackPurple";
      
      private static const GREEN_COLOR_ANIMATION_LIST:Array = ["goingTo","thanks","help_me_ex","help_me","supportingAlly","defendBase","defendingBase","defendObjective","defendingObjective"];
      
      private static const RED_COLOR_ANIMATION_LIST:Array = ["attackBase","attack","attackingBase","attackObjective","attackingObjective"];
      
      private static const ATTACK_BASE_COMMANDS:Array = ["attackBase","attackingBase"];
      
      private static const ATTACK_OBJECTIVE_COMMANDS:Array = ["attackObjective","attackingObjective"];
      
      private static const COMMAND_NAME_TO_FRAME_STATE:Object = {
         "":1,
         "attackingBase":2,
         "attackBase":2,
         "attention_to":3,
         "defendBase":4,
         "defendingBase":4,
         "attack":5,
         "help_me_ex":6,
         "help_me":6,
         "supportingAlly":6,
         "TARGET":7,
         "goingTo":8,
         "sos":9,
         "attackBasePurple":10,
         "attackPurple":11,
         "defendObjective":12,
         "defendingObjective":12,
         "attackObjective":13,
         "attackingObjective":13,
         "attackObjectivePurple":14
      };
      
      private static const TARGET_CHAT_CMD_FLAGS:uint = 1;
      
      private static const PLAYER_IS_CHAT_CMD_TARGET_FLAG:uint = 2;
       
      
      public var activeChatCommand:MovieClip = null;
      
      public var chatCommandAnimation:MovieClip = null;
      
      private var _activeChatCommand:String = "";
      
      private var _animationWidth:int = 410;
      
      private var _isColorBlind:Boolean = false;
      
      private var _chatCommandFlags:uint = 0;
      
      private var _shouldBeShown:Boolean = true;
      
      private var _disposed:Boolean = false;
      
      private var _isChatCommandAnimationVisible:Boolean = false;
      
      public function ChatCommandItemComponent()
      {
         super();
         this._isColorBlind = App.colorSchemeMgr.getIsColorBlindS();
         this.chatCommandAnimation.visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.chatCommandAnimation.stop();
         this.chatCommandAnimation = null;
         this.activeChatCommand = null;
      }
      
      public function iconOffset(param1:int) : void
      {
         this.activeChatCommand.x = param1;
         this._animationWidth = Math.abs(param1) * OFFSET_TO_ANIMATION_WIDTH_SCALE;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function playCommandAnimation(param1:String) : void
      {
         if(!this._isChatCommandAnimationVisible)
         {
            if(this.chatCommandAnimation.visible)
            {
               this.chatCommandAnimation.visible = false;
            }
            return;
         }
         if(!this.chatCommandAnimation.visible)
         {
            this.chatCommandAnimation.visible = true;
         }
         this.chatCommandAnimation.scaleX = this._animationWidth / SOURCE_ANIMATION_WIDTH;
         var _loc2_:String = ORANGE_STATE;
         if(GREEN_COLOR_ANIMATION_LIST.indexOf(param1) != INVALID_INDEX)
         {
            _loc2_ = GREEN_STATE;
         }
         else if(RED_COLOR_ANIMATION_LIST.indexOf(param1) != INVALID_INDEX)
         {
            _loc2_ = !!this._isColorBlind ? PURPLE_STATE : RED_STATE;
         }
         this.chatCommandAnimation.gotoAndStop(_loc2_);
         this.chatCommandAnimation.animationMC.gotoAndPlay(1);
      }
      
      public function setActiveChatCommand(param1:String, param2:uint) : void
      {
         if(this._activeChatCommand == param1 && param2 == this._chatCommandFlags)
         {
            return;
         }
         this._activeChatCommand = param1;
         this._chatCommandFlags = param2;
         if(param1 != EMPTY_FRAME_STATE)
         {
            this.playCommandAnimation(param1);
         }
         this.setChatCommandState(param1,param2);
      }
      
      public function setAnimationVisibility(param1:Boolean) : void
      {
         this._isChatCommandAnimationVisible = param1;
      }
      
      public function setChatCommandVisibility(param1:Boolean) : void
      {
         if(param1 == this._shouldBeShown)
         {
            return;
         }
         visible = this._shouldBeShown = param1;
      }
      
      public function updateColors(param1:Boolean) : void
      {
         if(this._isColorBlind == param1)
         {
            return;
         }
         this._isColorBlind = param1;
         if(this._activeChatCommand != EMPTY_FRAME_STATE)
         {
            this.setChatCommandState(this._activeChatCommand,this._chatCommandFlags);
         }
      }
      
      protected function updateChatCommandIcon(param1:String) : void
      {
         this.activeChatCommand.gotoAndStop(COMMAND_NAME_TO_FRAME_STATE[param1]);
      }
      
      private function setChatCommandState(param1:String, param2:uint) : void
      {
         var _loc3_:String = param1;
         if(GREEN_COLOR_ANIMATION_LIST.indexOf(param1) != INVALID_INDEX)
         {
            if((param2 & TARGET_CHAT_CMD_FLAGS) > 0)
            {
               _loc3_ = COMMAND_TARGET_STATE;
            }
            else if((param2 & PLAYER_IS_CHAT_CMD_TARGET_FLAG) > 0)
            {
               _loc3_ = PLAYER_IS_ALLY_TARGET_STATE;
            }
         }
         if(this._isColorBlind)
         {
            if(ATTACK_BASE_COMMANDS.indexOf(param1) != INVALID_INDEX)
            {
               _loc3_ = ATTACK_BASE_PURPLE_STATE;
            }
            else if(ATTACK_OBJECTIVE_COMMANDS.indexOf(param1) != INVALID_INDEX)
            {
               _loc3_ = ATTACK_OBJECTIVE_PURPLE_STATE;
            }
            else if(RED_COLOR_ANIMATION_LIST.indexOf(param1) != INVALID_INDEX)
            {
               _loc3_ = ATTACK_PURPLE_STATE;
            }
         }
         this.updateChatCommandIcon(_loc3_);
         this.activeChatCommand.visible = _loc3_ != EMPTY_FRAME_STATE;
         var _loc4_:ChatCommandItemEvent = new ChatCommandItemEvent(ChatCommandItemEvent.ACTIVE_COMMAND_CHANGED);
         _loc4_.isActiveCommandVisible = this.activeChatCommand.visible;
         dispatchEvent(_loc4_);
      }
   }
}
