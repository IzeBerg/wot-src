package net.wg.gui.battle.commander.views.fullStats.list.base
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsItem;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class AbstractRTSFullStatsItem extends UIComponentEx implements IRTSFullStatsItem
   {
      
      protected static const INVALID_FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      protected static const FLAGS_BORDER:uint = INVALID_FRAGS;
       
      
      protected var _frags:int = 0;
      
      public function AbstractRTSFullStatsItem()
      {
         super();
      }
      
      public function setData(param1:IDAAPIDataClass) : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function setFrags(param1:int) : void
      {
         if(this._frags != param1)
         {
            this._frags = param1;
            invalidate(INVALID_FRAGS);
         }
      }
   }
}
