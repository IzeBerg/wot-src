package net.wg.gui.lobby.clans.invites.views
{
   import flash.text.TextField;
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
   import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
   import net.wg.infrastructure.base.meta.IClanInvitesViewWithTableMeta;
   import net.wg.infrastructure.base.meta.impl.ClanInvitesViewWithTableMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ClanInvitesViewWithTable extends ClanInvitesViewWithTableMeta implements IClanInvitesViewWithTableMeta
   {
      
      private static const INV_DEFAULT_SORT_FIELD:String = "InvDefaultSortField";
       
      
      public var refreshButton:IButtonIconLoader = null;
      
      public var refreshBtnHintTF:TextField = null;
      
      public var table:ISortableTable = null;
      
      public var dummy:IDummy = null;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _model:ClanInvitesViewVO = null;
      
      private var _defaultSortField:String;
      
      private var _defaultSortDirection:String;
      
      public function ClanInvitesViewWithTable()
      {
         super();
         this._dataProvider = new SortableVoDAAPIDataProvider(this.getDataProviderVOClass());
      }
      
      override protected function onDispose() : void
      {
         this.refreshBtnHintTF = null;
         this.refreshButton.removeEventListener(ButtonEvent.CLICK,this.onRefreshButtonClickHandler);
         this.refreshButton.dispose();
         this.refreshButton = null;
         this.table.removeEventListener(ClanTableRendererItemEvent.SHOW_MORE_CLICKED,this.onTableShowMoreClickedHandler);
         this.table.dispose();
         this.table = null;
         this.dummy.dispose();
         this.dummy = null;
         this._dataProvider = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.listDP = this._dataProvider;
         this.table.isListSelectable = false;
         this.table.addEventListener(ClanTableRendererItemEvent.SHOW_MORE_CLICKED,this.onTableShowMoreClickedHandler);
         this.refreshButton.mouseEnabledOnDisabled = true;
         this.refreshButton.iconOffsetTop = -1;
         this.refreshButton.iconOffsetLeft = 1;
         this.refreshButton.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_CYBERSPORT_REFRESHICON;
         this.refreshButton.enabled = false;
         this.refreshButton.addEventListener(ButtonEvent.CLICK,this.onRefreshButtonClickHandler);
         this.refreshBtnHintTF.text = CLANS.CLANINVITESWINDOW_DATAUPDATED;
         this.refreshBtnHintTF.visible = false;
         this.dummy.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.table.headerDP = this._model.tableHeaders;
         }
         if(isInvalid(INV_DEFAULT_SORT_FIELD))
         {
            this.table.setSelectedField(this._defaultSortField,this._defaultSortDirection);
         }
      }
      
      override protected function showDummy(param1:DummyVO) : void
      {
         this.dummy.setData(param1);
         this.dummy.visible = true;
         this.table.listVisible = false;
      }
      
      public function as_getTableDP() : Object
      {
         return this._dataProvider;
      }
      
      public function as_hideDummy() : void
      {
         this.dummy.visible = false;
         this.table.listVisible = true;
      }
      
      override protected function setData(param1:ClanInvitesViewVO) : void
      {
         this._model = param1;
         invalidateData();
      }
      
      public function as_updateButtonRefreshState(param1:Boolean, param2:String) : void
      {
         this.refreshBtnHintTF.visible = param1;
         this.refreshButton.enabled = param1;
         this.refreshButton.tooltip = param2;
      }
      
      public function as_updateDefaultSortField(param1:String, param2:String) : void
      {
         this._defaultSortField = param1;
         this._defaultSortDirection = param2;
         invalidate(INV_DEFAULT_SORT_FIELD);
      }
      
      protected function getDataProviderVOClass() : Class
      {
         var _loc1_:String = "getDataProviderVOClass" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         throw new AbstractException(_loc1_);
      }
      
      private function onRefreshButtonClickHandler(param1:ButtonEvent) : void
      {
         if(this.refreshButton.enabled)
         {
            refreshTableS();
         }
      }
      
      private function onTableShowMoreClickedHandler(param1:ClanTableRendererItemEvent) : void
      {
         showMoreS();
      }
   }
}
