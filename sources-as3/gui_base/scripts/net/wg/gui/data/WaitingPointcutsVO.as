package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WaitingPointcutsVO extends DAAPIDataClass
   {
      
      private static const FIRST_POINTCUT_FIELD_NAME:String = "firstPointcut";
      
      private static const LAST_POINTCUT_FIELD_NAME:String = "lastPointcut";
       
      
      public var firstPointcut:WaitingPointcutItemVO;
      
      public var lastPointcut:WaitingPointcutItemVO;
      
      public var betweenPointcutsTextAlias:String = "";
      
      public function WaitingPointcutsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIRST_POINTCUT_FIELD_NAME)
         {
            this.firstPointcut = new WaitingPointcutItemVO(param2);
            return false;
         }
         if(param1 == LAST_POINTCUT_FIELD_NAME)
         {
            this.lastPointcut = new WaitingPointcutItemVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.firstPointcut.dispose();
         this.firstPointcut = null;
         this.lastPointcut.dispose();
         this.lastPointcut = null;
         super.onDispose();
      }
   }
}
