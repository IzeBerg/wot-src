package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.carousels.interfaces.ICarouselItemRenderer;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.eventBoards.events.FilterRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class LevelTypeFlagRenderer extends SoundListItemRenderer implements ICarouselItemRenderer
   {
      
      private static const LOADER_OFFSET:int = -2;
      
      private static const BG_WIDTH:int = 45;
      
      private static const BG_HEIGHT:int = 32;
       
      
      public var loader:UILoaderAlt;
      
      public var emptyFocusIndicator:MovieClip;
      
      protected var _rendererData:SimpleRendererVO = null;
      
      private var _canBeSelected:Boolean = true;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      public function LevelTypeFlagRenderer()
      {
         super();
         useHandCursor = true;
         allowDeselect = false;
         toggle = false;
         preventAutosizing = true;
         constraintsDisabled = true;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._rendererData = SimpleRendererVO(param1);
         this.selected = this._rendererData.selected;
         if(this.selected)
         {
            dispatchEvent(new FilterRendererEvent(FilterRendererEvent.ITEM_CLICK,index,int(this._rendererData.id),true));
         }
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         if(this.emptyFocusIndicator)
         {
            focusIndicator = this.emptyFocusIndicator;
         }
         addEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onRendererOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRendererOutHandler);
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._rendererData != null)
            {
               this.visible = true;
               this.loader.source = this._rendererData.value;
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.loader.dispose();
            this.loader = null;
         }
         this.emptyFocusIndicator = null;
         this._toolTipMgr = null;
         removeEventListener(ButtonEvent.CLICK,this.onRendererClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onRendererOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onRendererOutHandler);
         super.onDispose();
      }
      
      public function get canBeSelected() : Boolean
      {
         return this._canBeSelected;
      }
      
      public function set canBeSelected(param1:Boolean) : void
      {
         this._canBeSelected = param1;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this._canBeSelected)
         {
            super.handleMouseRelease(param1);
         }
      }
      
      private function onRendererClickHandler(param1:ButtonEvent) : void
      {
         selected = !selected;
         dispatchEvent(new FilterRendererEvent(FilterRendererEvent.ITEM_CLICK,index,int(this._rendererData.id),true));
      }
      
      private function onRendererOverHandler(param1:MouseEvent) : void
      {
         if(this._rendererData != null && StringUtils.isNotEmpty(this._rendererData.tooltip))
         {
            this._toolTipMgr.showComplex(this._rendererData.tooltip);
         }
      }
      
      private function onRendererOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this.loader.x = LOADER_OFFSET + (BG_WIDTH - this.loader.width >> 1);
         this.loader.y = LOADER_OFFSET + (BG_HEIGHT - this.loader.height >> 1);
      }
   }
}
