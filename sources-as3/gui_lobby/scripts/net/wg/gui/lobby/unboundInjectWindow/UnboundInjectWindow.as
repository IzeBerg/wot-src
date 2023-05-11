package net.wg.gui.lobby.unboundInjectWindow
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.Aliases;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.UnboundComponent;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IUnboundInjectWindowMeta;
   import net.wg.infrastructure.base.meta.impl.UnboundInjectWindowMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class UnboundInjectWindow extends UnboundInjectWindowMeta implements IUnboundInjectWindowMeta
   {
      
      private static const UB_COMPONENT_HEIGHT:int = 487;
      
      private static const GF_COMPONENT_OFFSET:int = 20;
      
      private static const THICKNESS_BORDER:int = 1;
       
      
      public var image:UILoaderAlt = null;
      
      public var btn:SoundButtonEx = null;
      
      public var ubComponent:UnboundComponent = null;
      
      public var gfComponent:GFInjectComponent = null;
      
      public function UnboundInjectWindow()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         canResize = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         window.title = DEVELOPMENT.WULF_UNBOUNDINJECTIONWINDOW_TITLE;
         window.setMaxHeight(StageSizeBoundaries.HEIGHT_1080);
         window.setMaxWidth(StageSizeBoundaries.WIDTH_1920);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.btn.addEventListener(MouseEvent.MOUSE_OVER,this.btnMouseOverHandler);
         this.btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnMouseOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Graphics = null;
         super.draw();
         if(isDAAPIInited && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = width - this.gfComponent.x - GF_COMPONENT_OFFSET >> 0;
            _loc2_ = height - UB_COMPONENT_HEIGHT - this.gfComponent.y - GF_COMPONENT_OFFSET >> 0;
            this.gfComponent.setSize(_loc1_,_loc2_);
            _loc3_ = this.gfComponent.graphics;
            _loc3_.clear();
            _loc3_.lineStyle(THICKNESS_BORDER,16711680);
            _loc3_.drawRect(-THICKNESS_BORDER,-THICKNESS_BORDER,_loc1_ + 2 * THICKNESS_BORDER,_loc2_ + 2 * THICKNESS_BORDER);
            _loc3_.endFill();
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.ubComponent,Aliases.UNBOUND_TEST_COMPONENT);
         registerFlashComponentS(this.gfComponent,Aliases.GAMEFACE_TEST_COMPONENT);
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.image.dispose();
         this.image = null;
         this.btn.removeEventListener(MouseEvent.MOUSE_OVER,this.btnMouseOverHandler);
         this.btn.removeEventListener(MouseEvent.MOUSE_OUT,this.btnMouseOutHandler);
         this.btn.dispose();
         this.btn = null;
         this.ubComponent = null;
         this.gfComponent = null;
         super.onDispose();
      }
      
      public function as_setData(param1:String, param2:String) : void
      {
         this.btn.label = param2;
         this.image.source = param1;
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         if(this.gfComponent.wrapper)
         {
            this.gfComponent.wrapper.dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function btnMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.GF_TEST_TOOLTIP,50,"IS2",true);
      }
      
      private function btnMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
