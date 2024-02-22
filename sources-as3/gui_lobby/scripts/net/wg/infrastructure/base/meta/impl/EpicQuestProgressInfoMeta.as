package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleResults.epic.vo.EpicQuestProgressInfoItemVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicQuestProgressInfoMeta extends BaseDAAPIComponent
   {
       
      
      public var showQuestById:Function;
      
      private var _vectorEpicQuestProgressInfoItemVO:Vector.<EpicQuestProgressInfoItemVO>;
      
      public function EpicQuestProgressInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EpicQuestProgressInfoItemVO = null;
         if(this._vectorEpicQuestProgressInfoItemVO)
         {
            for each(_loc1_ in this._vectorEpicQuestProgressInfoItemVO)
            {
               _loc1_.dispose();
            }
            this._vectorEpicQuestProgressInfoItemVO.splice(0,this._vectorEpicQuestProgressInfoItemVO.length);
            this._vectorEpicQuestProgressInfoItemVO = null;
         }
         super.onDispose();
      }
      
      public function showQuestByIdS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.showQuestById,"showQuestById" + Errors.CANT_NULL);
         this.showQuestById(param1,param2);
      }
      
      public final function as_updateData(param1:Array) : void
      {
         var _loc5_:EpicQuestProgressInfoItemVO = null;
         var _loc2_:Vector.<EpicQuestProgressInfoItemVO> = this._vectorEpicQuestProgressInfoItemVO;
         this._vectorEpicQuestProgressInfoItemVO = new Vector.<EpicQuestProgressInfoItemVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorEpicQuestProgressInfoItemVO[_loc4_] = new EpicQuestProgressInfoItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.updateData(this._vectorEpicQuestProgressInfoItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function updateData(param1:Vector.<EpicQuestProgressInfoItemVO>) : void
      {
         var _loc2_:String = "as_updateData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
