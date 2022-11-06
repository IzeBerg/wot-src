package net.wg.gui.components.common.waiting
{
   import flash.display.Sprite;
   import net.wg.infrastructure.base.meta.IWaitingTransitionMeta;
   import net.wg.infrastructure.base.meta.impl.WaitingTransitionMeta;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   
   public class WaitingTransition extends WaitingTransitionMeta implements IWaitingTransitionMeta, IRootAppMainContent
   {
       
      
      public var waiting:WaitingMc;
      
      public var bg:Sprite;
      
      public function WaitingTransition()
      {
         super();
         this.bg.visible = false;
      }
      
      override protected function onDispose() : void
      {
         if(this.waiting)
         {
            this.waiting.dispose();
            this.waiting = null;
         }
         this.bg = null;
         super.onDispose();
      }
      
      public function as_hideBG() : void
      {
         this.bg.visible = false;
      }
      
      public function as_setTransitionText(param1:String) : void
      {
         this.waiting.setMessage(param1);
      }
      
      public function as_showBG() : void
      {
         this.bg.visible = true;
      }
      
      public function as_updateStage(param1:int, param2:int, param3:Number) : void
      {
         this.waiting.scaleX = this.waiting.scaleY = param3;
         this.waiting.x = param1 - this.waiting.width >> 1;
         this.waiting.y = param2 - this.waiting.height >> 1;
         this.bg.scaleX = this.bg.scaleY = param3;
         this.bg.x = param1 >> 1;
         this.bg.y = param2 >> 1;
      }
   }
}
