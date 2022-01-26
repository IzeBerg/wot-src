package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class InfoMessageVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var message:String = "";
      
      public var returnBtnLabel:String = "";
      
      public function InfoMessageVO(param1:Object)
      {
         super(param1);
      }
   }
}
