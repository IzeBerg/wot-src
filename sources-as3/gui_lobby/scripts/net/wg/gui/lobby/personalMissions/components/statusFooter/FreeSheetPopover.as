package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.FreeSheetPopoverVO;
   import net.wg.gui.lobby.personalMissions.events.PawnedSheetRendererEvent;
   import net.wg.infrastructure.base.meta.IFreeSheetPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.FreeSheetPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class FreeSheetPopover extends FreeSheetPopoverMeta implements IFreeSheetPopoverMeta
   {
      
      private static const LIST_DATA_INV:String = "list_data_inv";
      
      private static const LIST_BOTTOM_PADDING:int = -142;
      
      private static const INFO_BOTTOM_PADDING:int = 12;
      
      private static const LIST_MAX_RENDERERS:int = 3;
      
      private static const RENDERER_HEIGHT:int = 66;
       
      
      public var headerTF:TextField = null;
      
      public var listSeparatorTop:Sprite = null;
      
      public var listSeparatorBottom:Sprite = null;
      
      public var list:ScrollingListEx = null;
      
      public var freeSheetsInfo:IUpdatableComponent = null;
      
      public var pawnedSheetsInfo:IUpdatableComponent = null;
      
      public var infoSeparator:Sprite = null;
      
      private var _separatorHitArea:Sprite;
      
      private var _data:FreeSheetPopoverVO = null;
      
      public function FreeSheetPopover()
      {
         this._separatorHitArea = new Sprite();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.list.addEventListener(PawnedSheetRendererEvent.CLICK,this.onListRendererClickHandler);
         addChild(this._separatorHitArea);
         this.listSeparatorBottom.hitArea = this._separatorHitArea;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this.list != null && this.list.dataProvider != null && isInvalid(LIST_DATA_INV))
         {
            _loc1_ = this.list.dataProvider.length;
            this.list.height = _loc1_ < LIST_MAX_RENDERERS ? Number(RENDERER_HEIGHT * _loc1_) : Number(RENDERER_HEIGHT * LIST_MAX_RENDERERS);
            this.listSeparatorBottom.y = this.list.y + this.list.height;
            invalidateSize();
         }
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.headerTF.htmlText = this._data.titleText;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.list.visible = this.listSeparatorTop.visible = this.listSeparatorBottom.visible = this._data.hasPawnedSheets;
               if(this._data.hasPawnedSheets)
               {
                  height = this.listSeparatorBottom.y + this.listSeparatorBottom.height + LIST_BOTTOM_PADDING;
               }
               else
               {
                  height = this.pawnedSheetsInfo.y + this.pawnedSheetsInfo.height + INFO_BOTTOM_PADDING;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.list.removeEventListener(PawnedSheetRendererEvent.CLICK,this.onListRendererClickHandler);
         this.list.dispose();
         this.list = null;
         this.freeSheetsInfo.dispose();
         this.freeSheetsInfo = null;
         this.pawnedSheetsInfo.dispose();
         this.pawnedSheetsInfo = null;
         this.headerTF = null;
         this.listSeparatorTop = null;
         this.listSeparatorBottom = null;
         this.infoSeparator = null;
         this._data = null;
         removeChild(this._separatorHitArea);
         this._separatorHitArea = null;
         super.onDispose();
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function setListDataProvider(param1:DataProvider) : void
      {
         if(this.list.dataProvider != null)
         {
            this.list.dataProvider.cleanUp();
         }
         this.list.dataProvider = param1;
         invalidate(LIST_DATA_INV);
      }
      
      override protected function setData(param1:FreeSheetPopoverVO) : void
      {
         this._data = param1;
         this.freeSheetsInfo.update(this._data.freeSheetsInfo);
         this.pawnedSheetsInfo.update(this._data.pawnedSheetsInfo);
         invalidateData();
      }
      
      private function onListRendererClickHandler(param1:PawnedSheetRendererEvent) : void
      {
         onTaskClickS(param1.idx);
      }
   }
}
