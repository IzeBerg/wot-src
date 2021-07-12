package net.wg.gui.battle.epicBattle.battleloading.components
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.battleloading.renderers.EpicBattleLoadingPlayerItemRenderer;
   import net.wg.gui.battle.epicBattle.views.data.EpicVehicleDataProvider;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.data.ListData;
   
   public class EpicBattleScrollingList extends ScrollingList
   {
       
      
      public function EpicBattleScrollingList()
      {
         super();
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:ListData = null;
         var _loc7_:EpicBattleLoadingPlayerItemRenderer = null;
         var _loc8_:DAAPIVehicleInfoVO = null;
         var _loc9_:EpicVehicleDataProvider = null;
         var _loc10_:EpicVehicleStatsVO = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _scrollPosition + _loc4_;
            _loc6_ = new ListData(_loc5_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc5_);
            _loc7_ = getRendererAt(_loc4_) as EpicBattleLoadingPlayerItemRenderer;
            if(_loc7_)
            {
               _loc7_.enabled = _loc4_ < _loc2_;
               _loc7_.setListData(_loc6_);
               if(param1[_loc4_])
               {
                  _loc8_ = param1[_loc4_] as DAAPIVehicleInfoVO;
                  if(_loc8_)
                  {
                     _loc7_.setData(_loc8_);
                  }
                  _loc9_ = _dataProvider as EpicVehicleDataProvider;
                  if(_loc9_)
                  {
                     _loc10_ = _loc9_.requestEpicData(_loc8_.vehicleID);
                     if(_loc10_)
                     {
                        _loc7_.setEpicData(_loc10_);
                     }
                  }
               }
               _loc7_.validateNow();
            }
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
   }
}
