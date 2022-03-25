package net.wg.gui.battle.commander.views.common
{
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   
   public class Reloading extends BaseIcon
   {
      
      private static const FRAME_DONE:String = "done";
      
      private static const FRAME_RELOADING:String = "reloading";
      
      private static const FRAME_NO_AMMO:String = "no_ammo";
      
      private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";
       
      
      public var textTF:TextField = null;
      
      private var _data:ReloadingData = null;
      
      private var _currentValue:Number = NaN;
      
      private var _currentFrame:String = "";
      
      public function Reloading()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textTF = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data != null)
         {
            _loc1_ = true;
            if(parent)
            {
               _loc1_ = parent.visible;
            }
            visible = isAlive && isShown && _loc1_;
            if(visible)
            {
               this._data.update();
               _loc2_ = FRAME_DONE;
               if(this._data.isNoAmmo)
               {
                  _loc2_ = FRAME_NO_AMMO;
               }
               else if(this._data.isReloading || this._data.isFreeze)
               {
                  _loc2_ = FRAME_RELOADING;
               }
               if(_loc2_ != this._currentFrame)
               {
                  gotoAndStop(_loc2_);
                  this._currentFrame = _loc2_;
               }
               this.setTime(this._data.value);
            }
         }
      }
      
      public function makeContext() : ReloadingData
      {
         this._data = new ReloadingData();
         this.setContext(this._data);
         return this._data;
      }
      
      public function setContext(param1:ReloadingData) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setReloading(param1:Number, param2:Number, param3:Number) : void
      {
         if(this._data.updateValues(param1,param2,param3))
         {
            invalidateData();
         }
      }
      
      private function setTime(param1:Number) : void
      {
         var _loc2_:String = null;
         if(this._currentValue != param1)
         {
            this._currentValue = param1;
            _loc2_ = ExternalInterface.call.apply(this,[FRACTIONAL_FORMAT_CMD,param1]);
            this.textTF.text = _loc2_.slice(0,_loc2_.length - 1);
         }
      }
      
      override public function validateNow(param1:Event = null) : void
      {
         super.validateNow(param1);
         if(this._data.isUpdateRequired)
         {
            invalidateData();
         }
      }
   }
}
