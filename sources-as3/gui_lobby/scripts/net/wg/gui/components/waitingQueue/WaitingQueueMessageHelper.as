package net.wg.gui.components.waitingQueue
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.WaitingPointcutItemVO;
   import net.wg.gui.data.WaitingPointcutsVO;
   import net.wg.gui.interfaces.IWaitingQueueMessageHelper;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class WaitingQueueMessageHelper implements IWaitingQueueMessageHelper
   {
      
      private static var _instance:WaitingQueueMessageHelper;
      
      private static const BETWEEN_TEXT_ALIAS_ASSERT_MESSAGE:String = "betweenPointcutsTextAlias" + Errors.CANT_EMPTY;
       
      
      public function WaitingQueueMessageHelper()
      {
         super();
      }
      
      public static function get instance() : WaitingQueueMessageHelper
      {
         if(_instance == null)
         {
            _instance = new WaitingQueueMessageHelper();
         }
         return _instance;
      }
      
      public function getTimeText(param1:uint, param2:WaitingPointcutsVO) : String
      {
         var _loc3_:WaitingPointcutItemVO = param2.firstPointcut;
         var _loc4_:WaitingPointcutItemVO = param2.lastPointcut;
         var _loc5_:String = param2.betweenPointcutsTextAlias;
         if(param1 < _loc3_.value)
         {
            return _loc3_.text;
         }
         if(param1 > _loc4_.value)
         {
            return _loc4_.text;
         }
         App.utils.asserter.assert(StringUtils.isNotEmpty(_loc5_),BETWEEN_TEXT_ALIAS_ASSERT_MESSAGE);
         return App.utils.locale.makeString(_loc5_,{"units":param1.toString()});
      }
      
      public function needTimeCounting(param1:uint, param2:WaitingPointcutsVO) : Boolean
      {
         return param1 <= param2.lastPointcut.value;
      }
   }
}
