package net.wg.gui.bootcamp.battleResult.containers.base
{
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.gui.bootcamp.battleResult.interfaces.IBattleResultRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseRenderer extends UIComponentEx implements IBattleResultRenderer
   {
       
      
      public var loader:UILoaderAlt = null;
      
      protected var data:BattleItemRendererVO;
      
      public function BaseRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.validateLayout();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.validateData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         this.loader.dispose();
         this.loader = null;
         this.data = null;
         super.onDispose();
      }
      
      public function setData(param1:BattleItemRendererVO) : void
      {
         this.data = param1;
         invalidateData();
      }
      
      protected function validateData() : void
      {
         this.loader.source = this.data.icon;
         invalidateLayout();
      }
      
      protected function validateLayout() : void
      {
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.validateLayout();
         dispatchEvent(new BattleViewEvent(BattleViewEvent.RENDERER_LOADED,Values.EMPTY_STR,true));
      }
   }
}
