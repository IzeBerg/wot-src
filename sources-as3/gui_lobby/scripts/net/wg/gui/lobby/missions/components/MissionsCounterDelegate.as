package net.wg.gui.lobby.missions.components
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import net.wg.gui.lobby.missions.data.MissionTabCounterVO;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonBar;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionsCounterDelegate extends EventDispatcher implements IDisposable
   {
       
      
      private var _tabs:ButtonBar = null;
      
      private var _tabsDataProvider:IDataProvider = null;
      
      private var _countersData:Vector.<MissionTabCounterVO> = null;
      
      private var _counterManager:ICounterManager = null;
      
      private var _tabsMap:Dictionary = null;
      
      private var _disposed:Boolean = false;
      
      public function MissionsCounterDelegate()
      {
         super();
         this._counterManager = App.utils.counterManager;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTabsMap();
         this._tabs = null;
         this._tabsDataProvider = null;
         this._countersData = null;
         this._counterManager = null;
      }
      
      public function setSettingsItems(param1:Vector.<MissionTabCounterVO>, param2:ButtonBar) : void
      {
         this.clearTabsMap();
         this._tabsMap = new Dictionary();
         this._tabs = param2;
         this._tabsDataProvider = param2.dataProvider;
         this._countersData = param1;
         this.createAllCounters();
      }
      
      private function createAllCounters() : void
      {
         var _loc2_:TabsDataVo = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         this._tabs.validateNow();
         var _loc1_:int = this._tabsDataProvider.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = this._tabsDataProvider[_loc5_];
            _loc3_ = _loc2_.linkage;
            _loc4_ = this.findCounterValue(_loc3_);
            if(_loc4_ > 0)
            {
               this.createCounter(_loc3_,_loc4_,this._tabs.getButtonAt(_loc5_));
            }
            _loc5_++;
         }
      }
      
      private function createCounter(param1:String, param2:int, param3:Button) : void
      {
         var _loc4_:TabCounterVO = new TabCounterVO(param3);
         _loc4_.counterValue = param2;
         this._tabsMap[param1] = _loc4_;
         this._counterManager.setCounter(param3,param2.toString());
      }
      
      private function clearTabsMap() : void
      {
         var _loc1_:TabCounterVO = null;
         if(this._tabsMap)
         {
            for each(_loc1_ in this._tabsMap)
            {
               this._counterManager.removeCounter(_loc1_.btn);
               _loc1_.dispose();
            }
            this._tabsMap = null;
         }
      }
      
      private function findCounterValue(param1:String) : int
      {
         var _loc2_:MissionTabCounterVO = null;
         for each(_loc2_ in this._countersData)
         {
            if(_loc2_.linkage == param1)
            {
               return _loc2_.value;
            }
         }
         return 0;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

import net.wg.infrastructure.interfaces.entity.IDisposable;
import scaleform.clik.controls.Button;

class TabCounterVO implements IDisposable
{
    
   
   private var _btn:Button = null;
   
   public var counterValue:int = 0;
   
   private var _disposed:Boolean = false;
   
   function TabCounterVO(param1:Button)
   {
      super();
      this._btn = param1;
   }
   
   public function dispose() : void
   {
      this._disposed = true;
      this._btn = null;
   }
   
   public function get btn() : Button
   {
      return this._btn;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
