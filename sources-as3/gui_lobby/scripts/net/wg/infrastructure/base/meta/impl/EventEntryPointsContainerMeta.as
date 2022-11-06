package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.eventEntryPoint.data.EntryPointVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventEntryPointsContainerMeta extends BaseDAAPIComponent
   {
       
      
      private var _vectorEntryPointVO:Vector.<EntryPointVO>;
      
      public function EventEntryPointsContainerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EntryPointVO = null;
         if(this._vectorEntryPointVO)
         {
            for each(_loc1_ in this._vectorEntryPointVO)
            {
               _loc1_.dispose();
            }
            this._vectorEntryPointVO.splice(0,this._vectorEntryPointVO.length);
            this._vectorEntryPointVO = null;
         }
         super.onDispose();
      }
      
      public final function as_updateEntries(param1:Array) : void
      {
         var _loc5_:EntryPointVO = null;
         var _loc2_:Vector.<EntryPointVO> = this._vectorEntryPointVO;
         this._vectorEntryPointVO = new Vector.<EntryPointVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorEntryPointVO[_loc4_] = new EntryPointVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updateEntries(this._vectorEntryPointVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function updateEntries(param1:Vector.<EntryPointVO>) : void
      {
         var _loc2_:String = "as_updateEntries" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
