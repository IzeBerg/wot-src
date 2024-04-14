package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.personalMissions.events.TankgirlRendererEvent;
   import net.wg.infrastructure.base.BaseViewWrapper;
   import net.wg.infrastructure.base.meta.ITankgirlsPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.TankgirlsPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class TankgirlsPopover extends TankgirlsPopoverMeta implements ITankgirlsPopoverMeta
   {
      
      private static const LIST_DATA_INV:String = "list_data_inv";
      
      private static const LIST_MAX_RENDERERS:int = 4;
      
      private static const RENDERER_HEIGHT:int = 65;
      
      private static const LIST_BOTTOM_PADDING:int = -142;
      
      private static const BOTTOM_SEPARATOR_PADDING:int = 0;
      
      private static const LIST_GAP:int = 6;
       
      
      public var headerTF:TextField = null;
      
      public var listSeparatorTop:Sprite = null;
      
      public var listSeparatorBottom:Sprite = null;
      
      public var list:ScrollingListEx = null;
      
      private var _separatorHitArea:Sprite;
      
      public function TankgirlsPopover()
      {
         this._separatorHitArea = new Sprite();
         super();
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.listSeparatorTop = null;
         this.listSeparatorBottom = null;
         this.list.removeEventListener(TankgirlRendererEvent.CLICK,this.onListClickHandler);
         this.list.dispose();
         this.list = null;
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
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this.list != null && this.list.dataProvider != null && isInvalid(LIST_DATA_INV))
         {
            _loc1_ = this.list.dataProvider.length;
            if(_loc1_ < LIST_MAX_RENDERERS)
            {
               this.list.height = RENDERER_HEIGHT * _loc1_ - (_loc1_ - 1) * LIST_GAP;
            }
            else
            {
               this.list.height = RENDERER_HEIGHT * LIST_MAX_RENDERERS - (LIST_MAX_RENDERERS - 1) * LIST_GAP;
            }
            this.listSeparatorBottom.y = this.list.y + this.list.height - BOTTOM_SEPARATOR_PADDING >> 0;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            height = this.listSeparatorBottom.y + this.listSeparatorBottom.height + LIST_BOTTOM_PADDING;
            BaseViewWrapper(wrapper).invalidateLayout();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerTF.text = PERSONAL_MISSIONS.PERSONALMISSIONS_TANKGIRLSPOPOVER_TITLE;
         addChild(this._separatorHitArea);
         this.listSeparatorBottom.hitArea = this._separatorHitArea;
         this.list.addEventListener(TankgirlRendererEvent.CLICK,this.onListClickHandler);
      }
      
      private function onListClickHandler(param1:TankgirlRendererEvent) : void
      {
         onRecruitClickS(param1.idx);
      }
   }
}
