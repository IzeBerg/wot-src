package net.wg.gui.lobby.sessionStats
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
   import net.wg.gui.lobby.sessionStats.components.SessionStatsTankInfoBackground;
   import net.wg.gui.lobby.sessionStats.components.SessionStatsTankInfoMainMark;
   import net.wg.gui.lobby.sessionStats.components.SessionStatsTankSmallName;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsTankInfoHeaderVO;
   import net.wg.gui.lobby.sessionStats.helpers.SessionStatsHelper;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.data.DataProvider;
   
   public class SessionStatsTankInfoHeaderBlock extends BaseTooltipBlock
   {
      
      private static const PARAMS_LIST_TILE_HEIGHT:int = 22;
      
      private static const PARAMS_LIST_GAP:int = 7;
      
      private static const MAIN_MARK_GAP:int = 32;
      
      private static const SMALL_NAME_GAP:int = 36;
      
      private static const MIN_MAIN_MARK_Y:int = 108;
       
      
      public var tankName:TextField = null;
      
      public var tankSmallName:SessionStatsTankSmallName = null;
      
      public var paramsList:SimpleTileList = null;
      
      public var mainMark:SessionStatsTankInfoMainMark = null;
      
      public var background:SessionStatsTankInfoBackground = null;
      
      private var _isDataApplied:Boolean = false;
      
      private var _data:SessionStatsTankInfoHeaderVO = null;
      
      public function SessionStatsTankInfoHeaderBlock()
      {
         super();
         this.paramsList.autoSize = true;
         this.paramsList.itemRenderer = App.utils.classFactory.getClass(Linkages.SESSION_PARAMS_LIST_RENDER_LINK);
         this.paramsList.tileHeight = PARAMS_LIST_TILE_HEIGHT;
         this.paramsList.directionMode = DirectionMode.HORIZONTAL;
         this.paramsList.verticalGap = PARAMS_LIST_GAP;
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearData();
         this._data = new SessionStatsTankInfoHeaderVO(param1);
         this._isDataApplied = false;
         invalidateBlock();
      }
      
      override protected function onDispose() : void
      {
         this.paramsList.dispose();
         this.paramsList = null;
         this.mainMark.dispose();
         this.mainMark = null;
         this.tankSmallName.dispose();
         this.tankSmallName = null;
         this.background.dispose();
         this.background = null;
         this.tankName = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         if(!this._isDataApplied)
         {
            this.applyData();
            return true;
         }
         this.layout();
         return false;
      }
      
      private function layout() : void
      {
         this.paramsList.validateNow();
         this.mainMark.x = SessionStatsHelper.TOTAL_WIDTH;
         this.mainMark.y = this.paramsList.y + this.paramsList.height - MAIN_MARK_GAP;
         if(this.mainMark.y < MIN_MAIN_MARK_Y)
         {
            this.mainMark.y = MIN_MAIN_MARK_Y;
         }
         this.tankSmallName.validateSize();
         this.tankSmallName.x = SMALL_NAME_GAP;
      }
      
      private function applyData() : void
      {
         this.tankName.htmlText = this._data.tankName;
         this.mainMark.setData(this._data.favoriteText);
         this.paramsList.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._data.tankParams));
         this.background.setSource(this._data.flagImage,this._data.tankImage);
         this.mainMark.visible = this._data.isFavorite;
         this.tankSmallName.visible = this._data.smallSize;
         this.tankSmallName.setData(this._data.tankType,this._data.tankTier,this._data.tankNameSmall,this._data.isElite);
         this.tankName.visible = !this._data.smallSize;
         this._isDataApplied = true;
      }
      
      private function clearData() : void
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
