package net.wg.gui.tutorial.components
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TutorialHintZone extends UIComponentEx
   {
      
      private static const COLOR:uint = 16711680;
      
      private static const ALPHA:Number = 0;
       
      
      private var _component:IEventDispatcher = null;
      
      public function TutorialHintZone(param1:IEventDispatcher)
      {
         this.updateBackground(1,1);
         super();
         this.mouseEnabled = false;
         this._component = param1;
         param1.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_)
         {
            this.updateBackground(_width,_height);
         }
      }
      
      override protected function onDispose() : void
      {
         this._component.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this._component = null;
         super.onDispose();
      }
      
      private function updateBackground(param1:Number, param2:Number) : void
      {
         this.graphics.clear();
         this.graphics.beginFill(COLOR,ALPHA);
         this.graphics.drawRect(0,0,param1,param2);
         this.graphics.endFill();
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc2_ = getBounds(App.stage);
         _loc3_ = param1.stageX / App.appScale;
         _loc4_ = param1.stageY / App.appScale;
         var _loc5_:Boolean = _loc3_ >= _loc2_.x && _loc3_ <= _loc2_.x + _loc2_.width;
         var _loc6_:Boolean = _loc4_ >= _loc2_.y && _loc4_ <= _loc2_.y + _loc2_.height;
         if(_loc5_ && _loc6_)
         {
            dispatchEvent(new MouseEvent(MouseEvent.CLICK,false));
         }
      }
   }
}
