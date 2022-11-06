package net.wg.infrastructure.base
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   
   public class BackportPopOverCaller extends Sprite implements IPopOverCaller
   {
       
      
      public function BackportPopOverCaller()
      {
         super();
      }
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.x = param1;
         this.y = param2;
         this.graphics.clear();
         this.graphics.beginFill(255);
         this.graphics.drawRect(0,0,param3,param4);
         this.graphics.endFill();
         App.popoverMgr.popoverCaller = this;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this;
      }
      
      public function getHitArea() : DisplayObject
      {
         return this;
      }
   }
}
