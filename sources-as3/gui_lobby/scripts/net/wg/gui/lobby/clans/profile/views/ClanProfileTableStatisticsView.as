package net.wg.gui.lobby.clans.profile.views
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.CLANS_ALIASES;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileProvinceVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSelfProvinceVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileTableStatisticsDataVO;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.infrastructure.base.meta.IClanProfileTableStatisticsViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileTableStatisticsViewMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileTableStatisticsView extends ClanProfileTableStatisticsViewMeta implements IResizableContent, IClanProfileTableStatisticsViewMeta
   {
       
      
      public var table:SortableTable = null;
      
      public var noDataText:TextField = null;
      
      public var additionalText:TextField = null;
      
      private var _dataProvider:SortableVoDAAPIDataProvider = null;
      
      private var _data:ClanProfileTableStatisticsDataVO = null;
      
      private var _renderDataClass:Class = null;
      
      public function ClanProfileTableStatisticsView()
      {
         super();
         this.additionalText.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.table.dispose();
         this.table = null;
         this.noDataText = null;
         this.additionalText = null;
         this._renderDataClass = null;
         this._data = null;
         this.clearDataProvider();
         super.onDispose();
      }
      
      override protected function setData(param1:ClanProfileTableStatisticsDataVO) : void
      {
         this.clearDataProvider();
         this._data = param1;
         this.table.headerDP = this._data.headers;
         this.table.sortByField(this._data.defaultSortField,this._data.defaultSortDirection);
         this.updateRenderer(this._data.rendererLinkage);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.isListSelectable = false;
         this.additionalText.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.table.listVisible = this._data.isListVisible;
            this.noDataText.visible = this._data.isNoDataTextVisible;
            if(this._data.isNoDataTextVisible)
            {
               this.noDataText.htmlText = this._data.noDataText;
            }
         }
      }
      
      public function as_getDP() : Object
      {
         if(this._dataProvider == null)
         {
            this._dataProvider = this.createDP();
         }
         return this._dataProvider;
      }
      
      public function as_setAdditionalText(param1:Boolean, param2:String) : void
      {
         this.additionalText.visible = param1;
         if(param1)
         {
            this.additionalText.htmlText = param2;
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.table.getComponentForFocus();
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         this.table.width = param1;
         this.table.height = param2;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function clearDataProvider() : void
      {
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
      }
      
      private function updateRenderer(param1:String) : void
      {
         this.table.rendererLinkage = param1;
         if(CLANS_ALIASES.CLAN_PROFILE_PROVINCE_RENDERER == param1)
         {
            this._renderDataClass = ClanProfileProvinceVO;
         }
         else if(CLANS_ALIASES.CLAN_PROFILE_SELF_PROVINCE_RENDERER == param1)
         {
            this._renderDataClass = ClanProfileSelfProvinceVO;
         }
         else
         {
            App.utils.asserter.assert(false,Errors.BAD_LINKAGE + param1);
         }
      }
      
      private function createDP() : SortableVoDAAPIDataProvider
      {
         App.utils.asserter.assertNotNull(this._renderDataClass,"_renderDataClass" + Errors.CANT_NULL);
         var _loc1_:SortableVoDAAPIDataProvider = new SortableVoDAAPIDataProvider(this._renderDataClass);
         this.table.listDP = _loc1_;
         _loc1_.invalidate();
         return _loc1_;
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
   }
}
