package net.wg.gui.battle.views.epicReinforcementPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.IEpicReinforcementPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicReinforcementPanelMeta;
   import net.wg.utils.IScheduler;
   
   public class EpicReinforcementPanel extends EpicReinforcementPanelMeta implements IEpicReinforcementPanelMeta
   {
      
      private static const MAX_DISPLAYED_TANKS:int = 2;
      
      private static const FULL_STATE:String = "full";
      
      private static const EMPTY_STATE:String = "empty";
      
      private static const ZERO_STRING:String = "0";
      
      private static const SEMICOLON_STRING:String = ":";
       
      
      public var timerTF:TextField = null;
      
      public var timerPrefixTF:TextField = null;
      
      public var tank1:MovieClip = null;
      
      public var tank2:MovieClip = null;
      
      public var tankAdd:MovieClip = null;
      
      private var _respawns:int = -1;
      
      private var _tankIconsList:Vector.<MovieClip> = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _timerTimestamp:Number = 0;
      
      public function EpicReinforcementPanel()
      {
         super();
         this.timerPrefixTF.visible = false;
         this.timerTF.visible = false;
         this._tankIconsList = new <MovieClip>[this.tank1,this.tank2];
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateCurrentTime);
         this._scheduler = null;
         this._tankIconsList.splice(0,this._tankIconsList.length);
         this._tankIconsList = null;
         this.timerTF = null;
         this.timerPrefixTF = null;
         this.tank1 = null;
         this.tank2 = null;
         this.tankAdd = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = this._respawns;
            _loc2_ = this._tankIconsList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._tankIconsList[_loc3_].gotoAndStop(_loc1_ > 0 ? FULL_STATE : EMPTY_STATE);
               _loc1_--;
               _loc3_++;
            }
            this.tankAdd.gotoAndStop(this._respawns == MAX_DISPLAYED_TANKS ? EMPTY_STATE : FULL_STATE);
         }
      }
      
      public function as_setPlayerLives(param1:int) : void
      {
         if(param1 < 0)
         {
            return;
         }
         var _loc2_:int = Math.max(0,param1 - 1);
         if(this._respawns == _loc2_)
         {
            return;
         }
         this._respawns = _loc2_;
         invalidateState();
      }
      
      public function as_setTime(param1:String) : void
      {
         this.timerTF.text = param1;
         this.timerPrefixTF.visible = true;
         this.timerTF.visible = true;
      }
      
      public function as_setTimestamp(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 - param2;
         if(_loc3_ > 0)
         {
            this._timerTimestamp = _loc3_;
            this._scheduler.scheduleRepeatableTask(this.updateCurrentTime,Time.MILLISECOND_IN_SECOND,_loc3_);
            this.timerPrefixTF.visible = true;
            this.timerTF.visible = true;
         }
      }
      
      private function updateCurrentTime() : void
      {
         --this._timerTimestamp;
         this.updateTimerTimestamp(this._timerTimestamp);
      }
      
      private function updateTimerTimestamp(param1:Number) : void
      {
         var _loc2_:Number = param1 % Time.SECONDS_IN_MINUTE;
         var _loc3_:Number = Math.floor(param1 / Time.SECONDS_IN_MINUTE);
         this.timerTF.text = (_loc3_ >= 10 ? Values.EMPTY_STR : ZERO_STRING) + _loc3_.toString() + SEMICOLON_STRING + (_loc2_ >= 10 ? Values.EMPTY_STR : ZERO_STRING) + Math.floor(_loc2_).toString();
      }
   }
}
