package net.wg.gui.components.controls.achievements
{
   import flash.events.Event;
   import net.wg.data.VO.ProgressSimpleInfo;
   
   public class AchievementProgress extends AchievementCounter
   {
      
      private static const PROGRESS_BAR_INVALID:String = "pbInv";
      
      public static const MILLIONS:String = "M";
      
      public static const THOUSANDS:String = "K";
       
      
      private var progress:AchievementProgressComponent;
      
      private var _progressInfo:ProgressSimpleInfo;
      
      public function AchievementProgress()
      {
         super();
      }
      
      public static function getShortTextValue(param1:Number) : String
      {
         var _loc2_:String = prepareShortString(param1,1000000,MILLIONS);
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = prepareShortString(param1,1000,THOUSANDS);
         if(_loc2_)
         {
            return _loc2_;
         }
         return getNiceStr(param1);
      }
      
      private static function prepareShortString(param1:Number, param2:Number, param3:String = "") : String
      {
         var _loc4_:int = 10;
         var _loc5_:Number = param1 * _loc4_ / param2;
         if(_loc5_ >= _loc4_)
         {
            return getNiceStr(Math.round(_loc5_) / _loc4_) + param3;
         }
         return null;
      }
      
      private static function getNiceStr(param1:Number) : String
      {
         var _loc2_:String = null;
         if(App.utils)
         {
            _loc2_ = App.utils.locale.numberWithoutZeros(param1);
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      public function set progressInfo(param1:ProgressSimpleInfo) : void
      {
         if(this._progressInfo != param1)
         {
            this._progressInfo = param1;
            invalidate(PROGRESS_BAR_INVALID);
         }
         else if(this._progressInfo && param1)
         {
            if(!this._progressInfo.isEquals(param1))
            {
               this._progressInfo = param1;
               invalidate(PROGRESS_BAR_INVALID);
            }
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(PROGRESS_BAR_INVALID))
         {
            if(this._progressInfo != null)
            {
               if(!this.progress)
               {
                  this.progress = AchievementProgressComponent(App.utils.classFactory.getComponent("AchievementProgressComponent_UI",AchievementProgressComponent));
                  this.progress.x = loader.x + (loader.originalWidth - this.progress.width) >> 1;
                  this.progress.y = loader.y + loader.originalHeight;
                  addChild(this.progress);
               }
               if(this.progress)
               {
                  this.progress.progressBar.minimum = this._progressInfo.min;
                  this.progress.progressBar.maximum = this._progressInfo.max;
                  this.progress.progressBar.value = this._progressInfo.current;
                  this.progress.progressTextField.text = getShortTextValue(this._progressInfo.current) + " / " + getShortTextValue(this._progressInfo.max);
               }
            }
            else if(this.progress)
            {
               this.progress.dispose();
               this.progress.parent.removeChild(this.progress);
               this.progress = null;
            }
            applyData();
         }
         super.draw();
      }
      
      override public function validateNow(param1:Event = null) : void
      {
         super.validateNow(param1);
      }
   }
}
