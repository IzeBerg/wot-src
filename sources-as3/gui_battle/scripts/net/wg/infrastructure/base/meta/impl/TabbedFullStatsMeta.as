package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.StatsBase;
   import net.wg.gui.lobby.settings.vo.TabsDataVo;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class TabbedFullStatsMeta extends StatsBase
   {
       
      
      private var _dataProviderTabsDataVo:DataProvider;
      
      public function TabbedFullStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TabsDataVo = null;
         if(this._dataProviderTabsDataVo)
         {
            for each(_loc1_ in this._dataProviderTabsDataVo)
            {
               _loc1_.dispose();
            }
            this._dataProviderTabsDataVo.cleanUp();
            this._dataProviderTabsDataVo = null;
         }
         super.onDispose();
      }
      
      public final function as_updateTabs(param1:Array) : void
      {
         var _loc5_:TabsDataVo = null;
         var _loc2_:DataProvider = this._dataProviderTabsDataVo;
         this._dataProviderTabsDataVo = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTabsDataVo[_loc4_] = new TabsDataVo(param1[_loc4_]);
            _loc4_++;
         }
         this.updateTabs(this._dataProviderTabsDataVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function updateTabs(param1:DataProvider) : void
      {
         var _loc2_:String = "as_updateTabs" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
