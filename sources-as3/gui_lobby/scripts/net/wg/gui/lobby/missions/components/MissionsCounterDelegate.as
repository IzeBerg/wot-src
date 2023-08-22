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
