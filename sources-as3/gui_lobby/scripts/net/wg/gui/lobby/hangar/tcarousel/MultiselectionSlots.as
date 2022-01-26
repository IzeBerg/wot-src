package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionInfoVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.gfx.TextFieldEx;
   
   public class MultiselectionSlots extends UIComponentEx
   {
      
      private static const LINK_MULTISELECTION_SLOT_RENDERER:String = "MultiselectionSlotRendererUI";
      
      private static const LIST_TILE_WIDTH:uint = 186;
      
      private static const LIST_TILE_HEIGHT:uint = 52;
      
      private static const INVALID_LAYOUT:String = "invalidLayout";
      
      private static const LIST_SHIFT:int = 12;
      
      private static const INFO_BLOCK_LEFT_PADDING:int = 14;
       
      
      public var fullStatusTxt:TextField = null;
      
      public var list:SimpleTileList = null;
      
      public var infoBlock:MultiselectionInfoBlock = null;
      
      private var _stageWidth:int = 0;
      
      public function MultiselectionSlots()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(INVALID_LAYOUT))
         {
            _loc1_ = this.infoBlock.width + this.list.width + INFO_BLOCK_LEFT_PADDING - LIST_SHIFT ^ 0;
            this.fullStatusTxt.width = this._stageWidth;
            this.infoBlock.x = this._stageWidth - _loc1_ >> 1;
            this.list.x = this.infoBlock.x + this.infoBlock.width + INFO_BLOCK_LEFT_PADDING ^ 0;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.fullStatusTxt,TextFieldEx.VALIGN_CENTER);
         this.list.itemRenderer = App.utils.classFactory.getClass(LINK_MULTISELECTION_SLOT_RENDERER);
         this.list.tileWidth = LIST_TILE_WIDTH;
         this.list.tileHeight = LIST_TILE_HEIGHT;
         this.list.directionMode = DirectionMode.HORIZONTAL;
         this.infoBlock.addEventListener(Event.RESIZE,this.onInfoBlockResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.list.dispose();
         this.list = null;
         this.infoBlock.removeEventListener(Event.RESIZE,this.onInfoBlockResizeHandler);
         this.infoBlock.dispose();
         this.infoBlock = null;
         this.fullStatusTxt = null;
         super.onDispose();
      }
      
      public function setData(param1:MultiselectionInfoVO) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = param1.showSlots;
         this.list.visible = _loc2_;
         this.fullStatusTxt.visible = !_loc2_;
         this.infoBlock.visible = _loc2_;
         if(_loc2_)
         {
            this.infoBlock.setData(param1.vehicleTypes,param1.statusSrt,param1.indicatorIsEnabled);
         }
         else
         {
            this.fullStatusTxt.htmlText = param1.formattedMessage;
         }
      }
      
      public function setWidth(param1:int) : void
      {
         this._stageWidth = param1;
         this.fullStatusTxt.width = param1;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this.list.dataProvider = param1;
      }
      
      private function onInfoBlockResizeHandler(param1:Event) : void
      {
         invalidate(INVALID_LAYOUT);
      }
   }
}
