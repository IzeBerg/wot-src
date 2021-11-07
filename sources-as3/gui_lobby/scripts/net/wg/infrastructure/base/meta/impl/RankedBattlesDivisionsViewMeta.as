package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionsViewVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesDivisionsViewMeta extends RankedBattlesViewStackComponent
   {
       
      
      public var onDivisionChanged:Function;
      
      private var _divisionsViewVO:DivisionsViewVO;
      
      public function RankedBattlesDivisionsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._divisionsViewVO)
         {
            this._divisionsViewVO.dispose();
            this._divisionsViewVO = null;
         }
         super.onDispose();
      }
      
      public function onDivisionChangedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onDivisionChanged,"onDivisionChanged" + Errors.CANT_NULL);
         this.onDivisionChanged(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:DivisionsViewVO = this._divisionsViewVO;
         this._divisionsViewVO = new DivisionsViewVO(param1);
         this.setData(this._divisionsViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:DivisionsViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
