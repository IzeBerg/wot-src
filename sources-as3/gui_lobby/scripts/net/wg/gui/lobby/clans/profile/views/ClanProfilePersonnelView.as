package net.wg.gui.lobby.clans.profile.views
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.lobby.clans.profile.VOs.ClanMemberVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfilePersonnelViewVO;
   import net.wg.infrastructure.base.meta.IClanProfilePersonnelViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfilePersonnelViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ClanProfilePersonnelView extends ClanProfilePersonnelViewMeta implements IClanProfilePersonnelViewMeta
   {
      
      private static const STATS_GAP:int = 44;
      
      private static const LINES_BORDER_GAP:int = 30;
       
      
      public var table:ISortableTable = null;
      
      public var group:IGroupEx = null;
      
      public var titleTF:TextField = null;
      
      public var leftLine:DashLine = null;
      
      public var rightLine:DashLine = null;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _data:ClanProfilePersonnelViewVO = null;
      
      public function ClanProfilePersonnelView()
      {
         super();
         currentLinkage = CLANS_ALIASES.CLAN_PROFILE_PERSONNEL_VIEW_LINKAGE;
         this._dataProvider = new SortableVoDAAPIDataProvider(ClanMemberVO);
         this.table.listDP = this._dataProvider;
      }
      
      override public function as_setData(param1:Object) : void
      {
         this.clearData();
         this._data = new ClanProfilePersonnelViewVO(param1);
         this.table.headerDP = this._data.tableHeaders;
         this.table.sortByField(this._data.defaultSortField,this._data.defaultSortDirection);
         this.group.dataProvider = this._data.statistics;
         this._dataProvider.invalidate();
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.table.dispose();
         this.table = null;
         this.group.dispose();
         this.group = null;
         this.leftLine.dispose();
         this.leftLine = null;
         this.rightLine.dispose();
         this.rightLine = null;
         this.titleTF = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this.clearData();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.leftLine.x = LINES_BORDER_GAP;
            this.leftLine.width = this.titleTF.x - LINES_BORDER_GAP >> 0;
            this.rightLine.width = width - this.titleTF.x - this.titleTF.width - LINES_BORDER_GAP >> 0;
            this.rightLine.x = width - this.rightLine.width - LINES_BORDER_GAP >> 0;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc1_.gap = STATS_GAP;
         this.group.layout = _loc1_;
         this.group.itemRendererLinkage = Linkages.ADVANCED_LINE_DESCR_ICON_TEXT_UI;
         this.titleTF.autoSize = TextFieldAutoSize.CENTER;
         this.table.isListSelectable = false;
      }
      
      public function as_getMembersDP() : Object
      {
         return this._dataProvider;
      }
      
      private function clearData() : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
      }
   }
}
