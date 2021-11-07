package net.wg.gui.lobby.clans.invites.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTabViewVO;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTableFilterVO;
   import net.wg.infrastructure.base.meta.IClanInvitesWindowAbstractTabViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanInvitesWindowAbstractTabViewMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.IUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   
   public class ClanInvitesWindowAbstractTabView extends ClanInvitesWindowAbstractTabViewMeta implements IViewStackContent, IClanInvitesWindowAbstractTabViewMeta
   {
      
      private static const LINE_MARGIN:int = 14;
      
      private static const FILTERS_LEFT_MARGIN:int = 14;
      
      private static const FILTERS_GAP:int = 60;
      
      private static const FILTERS_ICON_WIDTH:int = 30;
      
      private static const CONTENT_WIDTH:int = 1006;
      
      protected static const FILTERS_GROUP_NAME:String = "filtersGroup";
       
      
      public var lineSeparator:DashLine = null;
      
      protected var _model:ClanInvitesWindowTabViewVO = null;
      
      private var _filtersCollection:Vector.<RadioButton> = null;
      
      private var _filters:Dictionary;
      
      private var _filtersGroup:ButtonGroup = null;
      
      private var _utils:IUtils = null;
      
      public function ClanInvitesWindowAbstractTabView()
      {
         this._filters = new Dictionary();
         super();
         this._filtersGroup = ButtonGroup.getGroup(FILTERS_GROUP_NAME,this);
         this._utils = App.utils;
      }
      
      override protected function getClanInvitesViewVOForData(param1:Object) : ClanInvitesViewVO
      {
         this._model = new ClanInvitesWindowTabViewVO(param1);
         return this._model;
      }
      
      override protected function onDispose() : void
      {
         this.lineSeparator.dispose();
         this.lineSeparator = null;
         this.cleanFiltersCollection();
         this._utils.data.cleanupDynamicObject(this._filters);
         this._filters = null;
         this._filtersGroup.removeEventListener(Event.CHANGE,this.onFiltersGroupChangeHandler);
         this._filtersGroup.dispose();
         this._filtersGroup = null;
         this._utils = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.lineSeparator.x = LINE_MARGIN;
         this.lineSeparator.width = CONTENT_WIDTH - (LINE_MARGIN >> 1);
         this._filtersGroup.addEventListener(Event.CHANGE,this.onFiltersGroupChangeHandler);
      }
      
      override protected function updateFilterState(param1:ClanInvitesWindowTableFilterVO) : void
      {
         var _loc2_:RadioButton = RadioButton(this._filters[param1.alias]);
         _loc2_.label = param1.text;
         _loc2_.validateNow();
         this.layoutFilters();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Vector.<ClanInvitesWindowTableFilterVO> = null;
         var _loc2_:int = 0;
         var _loc3_:ClanInvitesWindowTableFilterVO = null;
         var _loc4_:RadioButton = null;
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.cleanFiltersCollection();
            this._filtersCollection = new Vector.<RadioButton>();
            _loc1_ = this._model.filters;
            _loc2_ = -1;
            for each(_loc3_ in _loc1_)
            {
               _loc4_ = this._filters[_loc3_.alias];
               this._utils.asserter.assertNotNull(_loc4_,"Filter with alias \'" + _loc3_.alias + "\' is not registered");
               _loc4_.label = _loc3_.text;
               _loc4_.validateNow();
               if(this._model.defaultFilter == _loc3_.alias)
               {
                  _loc2_ = this._filtersCollection.length;
               }
               this._filtersCollection.push(_loc4_);
            }
            this.layoutFilters();
            this._filtersGroup.setSelectedButtonByIndex(_loc2_);
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setControlsEnabled(param1:Boolean) : void
      {
         var _loc2_:RadioButton = null;
         for each(_loc2_ in this._filtersCollection)
         {
            _loc2_.enabled = param1;
         }
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function registerFilter(param1:String, param2:RadioButton) : void
      {
         param2.data = param1;
         param2.groupName = FILTERS_GROUP_NAME;
         this._filters[param1] = param2;
      }
      
      protected function layoutFilters() : void
      {
         var _loc2_:RadioButton = null;
         var _loc1_:int = FILTERS_LEFT_MARGIN;
         for each(_loc2_ in this._filtersCollection)
         {
            _loc2_.x = _loc1_;
            _loc1_ += _loc2_.textField.textWidth + FILTERS_GAP;
            _loc2_.width = _loc2_.textField.textWidth + FILTERS_ICON_WIDTH;
         }
      }
      
      private function cleanFiltersCollection() : void
      {
         if(this._filtersCollection != null)
         {
            this._filtersCollection.splice(0,this._filtersCollection.length);
            this._filtersCollection = null;
         }
      }
      
      private function onFiltersGroupChangeHandler(param1:Event) : void
      {
         filterByS(String(this._filtersGroup.selectedButton.data));
      }
   }
}
