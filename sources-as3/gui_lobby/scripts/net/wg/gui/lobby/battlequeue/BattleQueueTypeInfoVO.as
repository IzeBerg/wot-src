package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleQueueTypeInfoVO extends DAAPIDataClass
   {
       
      
      public var iconLabel:String = "";
      
      public var title:String = "";
      
      public var subTitle:String = "";
      
      public var footerText:String = "";
      
      public var description:String = "";
      
      public var additional:String = "";
      
      public var tankLabel:String = "";
      
      public var tankIcon:String = "";
      
      public var tankName:String = "";
      
      public var layoutStr:String = "";
      
      public function BattleQueueTypeInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
