package net.wg.gui.login.impl.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RssItemVo extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var link:String = "";
      
      public var description:String = "";
      
      public function RssItemVo(param1:Object)
      {
         super(param1);
      }
   }
}
