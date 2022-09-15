package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.events.Event;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.TileList;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class CrewSkinsMainContainer extends UIComponentEx
   {
       
      
      private const BOTTOM_GAP:int = 3;
      
      public var blockHistorical:CrewSkinsBlock;
      
      public var blockNonHistorical:CrewSkinsBlock;
      
      private var _historicalSkinsData:DataProvider;
      
      private var _nonHistoricalSkinsData:DataProvider;
      
      private var _lastActiveList:TileList;
      
      private var _nonHistoricalBlockVisibility:Boolean;
      
      private var _gap:Number;
      
      private var _dataInited:Boolean;
      
      private var _scrollInited:Boolean;
      
      public function CrewSkinsMainContainer()
      {
         super();
      }
      
      public function set nonHistoricalBlockVisibility(param1:Boolean) : void
      {
         this._nonHistoricalBlockVisibility = param1;
         this._scrollInited = false;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(Event.RESIZE,this.blockResizeHandler);
         this.blockHistorical.labelText = App.utils.locale.makeString(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_TOOLTIP_DESCRIPTION_HISTORIC_TRUE);
         this.blockHistorical.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler,false,0,true);
         this.blockNonHistorical.labelText = App.utils.locale.makeString(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_TOOLTIP_DESCRIPTION_HISTORIC_FALSE);
         this.blockNonHistorical.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler,false,0,true);
         this._gap = this.blockNonHistorical.y - this.blockHistorical.y - this.blockHistorical.height;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PersonalCaseEvent = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._historicalSkinsData)
            {
               this.blockHistorical.dataProvider = this._historicalSkinsData;
            }
            if(this._nonHistoricalSkinsData)
            {
               this.blockNonHistorical.dataProvider = this._nonHistoricalSkinsData;
            }
         }
         if(this.blockNonHistorical.isReady && this.blockHistorical.isReady && isInvalid(InvalidationType.SIZE))
         {
            if(this.blockHistorical.dataProvider && this.blockHistorical.dataProvider.length)
            {
               this.blockHistorical.visible = true;
            }
            else
            {
               this.blockHistorical.visible = false;
            }
            if(this.blockNonHistorical.dataProvider && this.blockNonHistorical.dataProvider.length && this._nonHistoricalBlockVisibility)
            {
               this.blockNonHistorical.visible = true;
               this.blockNonHistorical.y = Boolean(this.blockHistorical.y + this.blockHistorical.visible) ? Number(this.blockHistorical.height + this._gap) : Number(0);
            }
            else
            {
               this.blockNonHistorical.visible = false;
            }
            if(this.blockNonHistorical.visible)
            {
               _height = this.blockNonHistorical.y + this.blockNonHistorical.height + this.BOTTOM_GAP;
            }
            else
            {
               _height = this.blockHistorical.y + this.blockHistorical.height + this.BOTTOM_GAP;
            }
            if(this._lastActiveList)
            {
               if(!this._lastActiveList.parent.visible)
               {
                  this._lastActiveList.selectedIndex = -1;
                  this._lastActiveList = null;
               }
               this.updateSelectedCrewSkinInfo();
            }
            if(this._lastActiveList)
            {
               _loc1_ = this._lastActiveList.selectedIndex;
            }
            else if(this._dataInited)
            {
               _loc1_ = this.searchEquipSkinIndex(this._historicalSkinsData);
               if(_loc1_ == -1)
               {
                  if(this.blockNonHistorical.visible)
                  {
                     _loc1_ = this.searchEquipSkinIndex(this._nonHistoricalSkinsData);
                     if(_loc1_ == -1)
                     {
                        if(this._historicalSkinsData.length > 0)
                        {
                           this._lastActiveList = this.blockHistorical.tileList;
                           _loc1_ = 0;
                        }
                        else if(this._nonHistoricalSkinsData.length > 0)
                        {
                           this._lastActiveList = this.blockNonHistorical.tileList;
                           _loc1_ = 0;
                        }
                     }
                     else
                     {
                        this._lastActiveList = this.blockNonHistorical.tileList;
                     }
                  }
                  else if(this._historicalSkinsData.length > 0)
                  {
                     this._lastActiveList = this.blockHistorical.tileList;
                     _loc1_ = 0;
                  }
               }
               else
               {
                  this._lastActiveList = this.blockHistorical.tileList;
               }
               if(this._lastActiveList)
               {
                  this._lastActiveList.selectedIndex = _loc1_;
               }
            }
            if(this._lastActiveList && !this._scrollInited)
            {
               this._scrollInited = true;
               _loc2_ = new PersonalCaseEvent(PersonalCaseEvent.INIT_CREW_SKINS_SCROLL,true);
               _loc2_.selectedCrewSkinPosY = this._lastActiveList.parent.y + this._lastActiveList.y + (_loc1_ / this._lastActiveList.columnCount | 0) * this._lastActiveList.rowHeight;
               dispatchEvent(_loc2_);
            }
         }
      }
      
      private function searchEquipSkinIndex(param1:Array) : int
      {
         var _loc3_:CrewSkinVO = null;
         var _loc2_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            if(_loc3_.isEquip)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(Event.RESIZE,this.blockResizeHandler);
         this.blockHistorical.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
         this.blockHistorical.dispose();
         this.blockHistorical = null;
         this.blockNonHistorical.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
         this.blockNonHistorical.dispose();
         this.blockNonHistorical = null;
         this._historicalSkinsData = null;
         this._nonHistoricalSkinsData = null;
         this._lastActiveList = null;
         super.onDispose();
      }
      
      public function updateCrewSkinsData(param1:DataProvider, param2:DataProvider) : void
      {
         this._historicalSkinsData = param1;
         this._nonHistoricalSkinsData = param2;
         this._dataInited = true;
         invalidateData();
      }
      
      private function updateSelectedCrewSkinInfo() : void
      {
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.UPDATE_SELECTED_CREW_SKIN_INFO,true);
         _loc1_.crewSkinModel = Boolean(this._lastActiveList) ? this._lastActiveList.dataProvider[this._lastActiveList.selectedIndex] : null;
         dispatchEvent(_loc1_);
      }
      
      private function blockResizeHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         invalidateSize();
      }
      
      private function onIndexChangeHandler(param1:ListEvent) : void
      {
         if(param1.index != -1 && this._lastActiveList != param1.target)
         {
            if(this._lastActiveList)
            {
               this._lastActiveList.selectedIndex = -1;
            }
            this._lastActiveList = TileList(param1.target);
         }
         this.updateSelectedCrewSkinInfo();
      }
   }
}
