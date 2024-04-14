package net.wg.gui.lobby.post.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TeaserVO extends DAAPIDataClass
   {
       
      
      public var postTitle:String = "";
      
      public var postCounter:int = 0;
      
      public var descr:String = "";
      
      public var title:String = "";
      
      public var image:String = "";
      
      public var isVideo:Boolean = false;
      
      public var isShopPromo:Boolean = false;
      
      public function TeaserVO(param1:Object)
      {
         super(param1);
      }
   }
}
