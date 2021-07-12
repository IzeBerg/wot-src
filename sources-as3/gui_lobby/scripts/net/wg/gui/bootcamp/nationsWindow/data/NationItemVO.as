package net.wg.gui.bootcamp.nationsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NationItemVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var label:String = "";
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public function NationItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
