package net.wg.gui.lobby.window
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.tooltips.inblocks.TooltipInBlocks;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.base.meta.IModuleInfoMeta;
   import net.wg.infrastructure.base.meta.impl.ModuleInfoMeta;
   import net.wg.infrastructure.interfaces.IToolTip;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class ModuleInfo extends ModuleInfoMeta implements IModuleInfoMeta
   {
      
      private static const NOT_INITED_HEIGHT:int = 550;
      
      private static const MIN_WIDTH:int = 430;
      
      private static const ADDITIONAL_RIGHT_PADDING:int = 10;
      
      private static const MIDDLE_PADDING:uint = 5;
      
      private static const BLOCKS_NAME:String = "blocks";
      
      private static const PROPS:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,-10,-10,MIN_WIDTH,0,0,MIN_WIDTH);
      
      private static const BUTTON_X_OFFSET:int = 10;
       
      
      public var closeBottomBtn:SoundButtonEx = null;
      
      private var _blocks:TooltipInBlocks = null;
      
      private var _blocksMask:Shape = null;
      
      private var _windowTitle:String = "";
      
      private var _sizeInitialized:Boolean = false;
      
      public function ModuleInfo()
      {
         super();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.closeBottomBtn);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         window.alpha = alpha = 0;
         this.closeBottomBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
         window.useBottomBtns = true;
         var _loc1_:Padding = window.contentPadding as Padding;
         App.utils.asserter.assertNotNull(_loc1_,Errors.CANT_NULL);
         _loc1_.right += ADDITIONAL_RIGHT_PADDING;
         window.contentPadding = _loc1_;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true);
      }
      
      override protected function onDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
         if(this._blocks)
         {
            this._blocks.removeEventListener(Event.RESIZE,this.onBlocksResizeHandler);
            this._blocks.dispose();
            this._blocks = null;
         }
         this._blocksMask = null;
         this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBottomBtnClickHandler);
         this.closeBottomBtn.dispose();
         this.closeBottomBtn = null;
         super.onDispose();
      }
      
      public function as_setModuleInfo(param1:Object) : void
      {
         var _loc2_:Graphics = null;
         this._windowTitle = param1.windowTitle;
         if(this._blocks == null)
         {
            this._blocks = App.utils.classFactory.getComponent(TOOLTIPS_CONSTANTS.INBLOCKS_DEFAULT_UI,DisplayObject,PROPS);
            this._blocks.name = BLOCKS_NAME;
            this._blocks.addEventListener(Event.RESIZE,this.onBlocksResizeHandler);
            this._blocks.background.visible = false;
            addChild(this._blocks);
            swapChildren(this._blocks,this.closeBottomBtn);
            if(!this._blocksMask)
            {
               this._blocksMask = new Shape();
               _loc2_ = this._blocksMask.graphics;
               _loc2_.beginFill(0);
               _loc2_.drawRect(0,0,1,1);
               _loc2_.endFill();
               addChild(this._blocksMask);
            }
            this._blocks.mask = this._blocksMask;
         }
         if(this._blocks != null)
         {
            IToolTip(this._blocks).build(param1,PROPS);
         }
      }
      
      override public function get width() : Number
      {
         if(this._sizeInitialized)
         {
            return this._blocksMask.width;
         }
         return MIN_WIDTH;
      }
      
      override public function get height() : Number
      {
         if(this._sizeInitialized)
         {
            return this.closeBottomBtn.y + this.closeBottomBtn.height;
         }
         return NOT_INITED_HEIGHT;
      }
      
      private function onBlocksResizeHandler(param1:Event) : void
      {
         this._blocksMask.x = this._blocks.x = this._blocks.bgHighlightMc.x = 0;
         this._blocksMask.y = this._blocks.y = this._blocks.bgHighlightMc.y = 0;
         var _loc2_:int = this._blocksMask.width = Math.max(MIN_WIDTH,this._blocks.background.width);
         this.closeBottomBtn.x = _loc2_ - this.closeBottomBtn.width + BUTTON_X_OFFSET | 0;
         this._blocksMask.height = this._blocks.contentHeight;
         var _loc3_:uint = this._blocks.y + this._blocks.contentHeight;
         this.closeBottomBtn.y = _loc3_ + MIDDLE_PADDING;
         window.title = this._windowTitle;
         window.titleUseHtml = true;
         window.invalidate(Window.INVALID_SRC_VIEW);
         this._sizeInitialized = true;
         window.alpha = alpha = 1;
         setFocus(this.closeBottomBtn);
      }
      
      private function onCloseBottomBtnClickHandler(param1:ButtonEvent) : void
      {
         onCancelClickS();
      }
      
      private function onEscapeKeyDownHandler(param1:Event) : void
      {
         onCancelClickS();
      }
   }
}
