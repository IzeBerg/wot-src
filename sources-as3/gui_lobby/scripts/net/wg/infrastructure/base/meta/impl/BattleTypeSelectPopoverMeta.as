package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.header.itemSelectorPopover.ExtraItemSelectorRendererVO;
   import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRendererVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class BattleTypeSelectPopoverMeta extends SmartPopOverView
   {
       
      
      public var selectFight:Function;
      
      public var demoClick:Function;
      
      public var getTooltipData:Function;
      
      private var _dataProviderItemSelectorRendererVO:DataProvider;
      
      private var _dataProviderExtraItemSelectorRendererVO:DataProvider;
      
      public function BattleTypeSelectPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ItemSelectorRendererVO = null;
         var _loc2_:ExtraItemSelectorRendererVO = null;
         if(this._dataProviderItemSelectorRendererVO)
         {
            for each(_loc1_ in this._dataProviderItemSelectorRendererVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderItemSelectorRendererVO.cleanUp();
            this._dataProviderItemSelectorRendererVO = null;
         }
         if(this._dataProviderExtraItemSelectorRendererVO)
         {
            for each(_loc2_ in this._dataProviderExtraItemSelectorRendererVO)
            {
               _loc2_.dispose();
            }
            this._dataProviderExtraItemSelectorRendererVO.cleanUp();
            this._dataProviderExtraItemSelectorRendererVO = null;
         }
         super.onDispose();
      }
      
      public function selectFightS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.selectFight,"selectFight" + Errors.CANT_NULL);
         this.selectFight(param1);
      }
      
      public function demoClickS() : void
      {
         App.utils.asserter.assertNotNull(this.demoClick,"demoClick" + Errors.CANT_NULL);
         this.demoClick();
      }
      
      public function getTooltipDataS(param1:String, param2:Boolean) : Object
      {
         App.utils.asserter.assertNotNull(this.getTooltipData,"getTooltipData" + Errors.CANT_NULL);
         return this.getTooltipData(param1,param2);
      }
      
      public final function as_update(param1:Array, param2:Array, param3:Boolean, param4:Boolean) : void
      {
         var _loc11_:ItemSelectorRendererVO = null;
         var _loc12_:ExtraItemSelectorRendererVO = null;
         var _loc5_:DataProvider = this._dataProviderItemSelectorRendererVO;
         this._dataProviderItemSelectorRendererVO = new DataProvider();
         var _loc6_:uint = param1.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            this._dataProviderItemSelectorRendererVO[_loc7_] = new ItemSelectorRendererVO(param1[_loc7_]);
            _loc7_++;
         }
         var _loc8_:DataProvider = this._dataProviderExtraItemSelectorRendererVO;
         this._dataProviderExtraItemSelectorRendererVO = new DataProvider();
         var _loc9_:uint = param2.length;
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            this._dataProviderExtraItemSelectorRendererVO[_loc10_] = new ExtraItemSelectorRendererVO(param2[_loc10_]);
            _loc10_++;
         }
         this.update(this._dataProviderItemSelectorRendererVO,this._dataProviderExtraItemSelectorRendererVO,param3,param4);
         if(_loc5_)
         {
            for each(_loc11_ in _loc5_)
            {
               _loc11_.dispose();
            }
            _loc5_.cleanUp();
         }
         if(_loc8_)
         {
            for each(_loc12_ in _loc8_)
            {
               _loc12_.dispose();
            }
            _loc8_.cleanUp();
         }
      }
      
      protected function update(param1:DataProvider, param2:DataProvider, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc5_);
         throw new AbstractException(_loc5_);
      }
   }
}
