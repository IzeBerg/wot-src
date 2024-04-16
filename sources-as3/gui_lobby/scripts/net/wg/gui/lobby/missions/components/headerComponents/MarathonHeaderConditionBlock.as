package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.lobby.missions.data.MarathonHeaderConditionBlockVO;
   import net.wg.gui.lobby.missions.interfaces.IMarathonHeaderBlock;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class MarathonHeaderConditionBlock extends UIComponentEx implements IMarathonHeaderBlock
   {
      
      private static const RENDERER_WIDTH_NORMAL:int = 110;
      
      private static const RENDERER_WIDTH_BIG:int = 128;
      
      private static const RENDERER_HEIGHT:int = 100;
      
      private static const RENDERERS_HORIZONTAL_GAP_NORMAL:int = -26;
      
      private static const RENDERERS_HORIZONTAL_GAP_SMALL:int = -36;
      
      private static const RENDERERS_VERTICAL_GAP:int = 10;
      
      private static const BIG_RENDERERS_NUMBER:int = 2;
      
      private static const MAX_RENDERERS_IN_ROW_NUMBER:int = 4;
      
      private static const CONTENT_START_Y:int = 32;
       
      
      public var title:TextField;
      
      public var tokensList:SimpleTileList;
      
      private var _data:MarathonHeaderConditionBlockVO;
      
      private var _contentHeight:int;
      
      public function MarathonHeaderConditionBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tokensList.itemRenderer = App.utils.classFactory.getClass(Linkages.MARATHON_HEADER_CONDITION_ITEM_RENDERER_UI);
         this.tokensList.tileHeight = RENDERER_HEIGHT;
         this.tokensList.verticalGap = RENDERERS_VERTICAL_GAP;
         this.tokensList.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         this.tokensList.y = CONTENT_START_Y;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._data.title;
            this.updateListParams(this._data.tokensData.length);
            this.tokensList.dataProvider = this._data.tokensData;
            this.tokensList.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this._contentHeight = RENDERER_HEIGHT;
            if(this.tokensList.length > MAX_RENDERERS_IN_ROW_NUMBER)
            {
               this._contentHeight += RENDERER_HEIGHT + RENDERERS_VERTICAL_GAP;
            }
            _loc1_ = this.tokensList.y + this._contentHeight;
            if(height != _loc1_)
            {
               height = _loc1_;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.tokensList.dispose();
         this.tokensList = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setContentTopPadding(param1:int) : void
      {
         this.tokensList.y = param1 + CONTENT_START_Y;
      }
      
      public function setData(param1:Object) : void
      {
         if(this._data != param1)
         {
            this._data = MarathonHeaderConditionBlockVO(param1);
            invalidateData();
         }
      }
      
      private function updateListParams(param1:int) : void
      {
         if(param1 > 0)
         {
            this.tokensList.tileWidth = param1 <= BIG_RENDERERS_NUMBER ? uint(RENDERER_WIDTH_BIG) : uint(RENDERER_WIDTH_NORMAL);
            this.tokensList.horizontalGap = param1 >= MAX_RENDERERS_IN_ROW_NUMBER ? Number(RENDERERS_HORIZONTAL_GAP_SMALL) : Number(RENDERERS_HORIZONTAL_GAP_NORMAL);
         }
      }
      
      public function get contentHeight() : int
      {
         return this._contentHeight;
      }
   }
}
