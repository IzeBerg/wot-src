package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SmokeGenerator extends UIComponentEx
   {
      
      private static const TIME:Number = 100;
      
      private static const SMOKE_VELOCITY:Number = 20;
      
      private static const SMOKE_UI:String = "SmokeUI";
       
      
      private var _smokeList:Vector.<Sprite>;
      
      public function SmokeGenerator()
      {
         this._smokeList = new Vector.<Sprite>(0);
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         var _loc6_:int = 0;
         var _loc7_:Sprite = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = 0;
            _loc2_ = 0;
            for each(_loc3_ in this._smokeList)
            {
               _loc4_ = _loc3_.width;
               _loc1_ += _loc4_;
               _loc3_.x = -_loc4_ + _loc2_++ * _loc4_;
            }
            while(_loc1_ < width)
            {
               _loc5_ = App.utils.classFactory.getComponent(SMOKE_UI,Sprite);
               _loc6_ = -_loc5_.width;
               if(this._smokeList.length > 0)
               {
                  _loc7_ = this._smokeList[this._smokeList.length - 1];
                  _loc6_ = _loc7_.x + _loc7_.width;
               }
               _loc5_.x = _loc6_;
               addChild(_loc5_);
               _loc1_ = _loc6_ + _loc5_.width;
               this._smokeList.push(_loc5_);
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.scheduler.scheduleRepeatableTask(this.update,TIME,int.MAX_VALUE);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Sprite = null;
         App.utils.scheduler.cancelTask(this.update);
         for each(_loc1_ in this._smokeList)
         {
            removeChild(_loc1_);
         }
         this._smokeList.splice(0,this._smokeList.length);
         this._smokeList = null;
         super.onDispose();
      }
      
      private function update() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:Number = TIME / 1000;
         for each(_loc2_ in this._smokeList)
         {
            _loc2_.x += SMOKE_VELOCITY * _loc1_;
            if(_loc2_.x > width)
            {
               _loc2_.x = this._smokeList[0].x - _loc2_.width;
               this._smokeList.splice(this._smokeList.indexOf(_loc2_),1);
               this._smokeList.unshift(_loc2_);
            }
         }
      }
   }
}
