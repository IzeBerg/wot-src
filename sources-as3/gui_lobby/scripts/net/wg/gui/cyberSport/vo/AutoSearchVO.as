package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AutoSearchVO extends DAAPIDataClass
   {
       
      
      public var state:String = "";
      
      public var countDownSeconds:int = 0;
      
      public var timeDirection:int = 1;
      
      public var contextMessage:String = "";
      
      public var playersReadiness:Array;
      
      public var canInvokeAutoSearch:Boolean = false;
      
      public var canInvokeBattleQueue:Boolean = false;
      
      public var extraData:Object = null;
      
      public function AutoSearchVO(param1:Object)
      {
         super(param1);
      }
   }
}
