package net.wg.gui.bootcamp.tooltipsWindow
{
   import net.wg.infrastructure.base.meta.IBCTooltipsWindowMeta;
   import net.wg.infrastructure.base.meta.impl.BCTooltipsWindowMeta;
   
   public class BCTooltipsWindow extends BCTooltipsWindowMeta implements IBCTooltipsWindowMeta
   {
      
      private static const COMPLETE_LABEl:String = "complete";
      
      private static const OUT_LABEL:String = "out";
      
      private static const SHOW_LABEL:String = "show";
      
      private static const FINISH_FRAME:int = 70;
       
      
      public var tooltip:BCTooltip = null;
      
      public function BCTooltipsWindow()
      {
         focusable = false;
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.tooltip.x = param1 >> 1;
         this.tooltip.updateStage(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.tooltip.setText(BOOTCAMP.HINT_CAMERA_CONTROLS);
      }
      
      override protected function onDispose() : void
      {
         this.tooltip.stop();
         this.tooltip.addFrameScript(FINISH_FRAME,null);
         this.tooltip.dispose();
         this.tooltip = null;
         super.onDispose();
      }
      
      public function as_completeHandler() : void
      {
         this.tooltip.gotoAndPlay(COMPLETE_LABEl);
      }
      
      public function as_hideHandler() : void
      {
         this.tooltip.gotoAndPlay(OUT_LABEL);
         this.tooltip.addFrameScript(FINISH_FRAME,this.onFinishFrame);
      }
      
      public function as_setRotateTipVisibility(param1:Boolean) : void
      {
         this.tooltip.visible = param1;
      }
      
      public function as_showHandler() : void
      {
         this.tooltip.gotoAndPlay(SHOW_LABEL);
      }
      
      private function onFinishFrame() : void
      {
         this.tooltip.stop();
         animFinishS();
      }
   }
}
