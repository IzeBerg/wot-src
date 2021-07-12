package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationCarouselDataVO extends DAAPIDataClass
   {
      
      private static const ITEM_LAYOUT_SIZE_FIELD:String = "itemLayoutSize";
      
      private static const BOOKMARKS_FIELD:String = "bookmarks";
       
      
      public var displayString:String = "";
      
      public var isZeroCount:Boolean = false;
      
      public var shouldShow:Boolean = false;
      
      public var itemLayoutSize:Vector.<Boolean> = null;
      
      public var bookmarks:Vector.<CustomizationCarouselBookmarkVO> = null;
      
      public function CustomizationCarouselDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         if(param1 == ITEM_LAYOUT_SIZE_FIELD)
         {
            this.itemLayoutSize = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this.itemLayoutSize.push(_loc3_);
            }
            return false;
         }
         if(param1 == BOOKMARKS_FIELD)
         {
            this.bookmarks = new Vector.<CustomizationCarouselBookmarkVO>();
            for each(_loc4_ in param2)
            {
               this.bookmarks.push(new CustomizationCarouselBookmarkVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.itemLayoutSize)
         {
            this.itemLayoutSize.splice(0,this.itemLayoutSize.length);
            this.itemLayoutSize = null;
         }
         if(this.bookmarks)
         {
            for each(_loc1_ in this.bookmarks)
            {
               _loc1_.dispose();
            }
            this.bookmarks.splice(0,this.bookmarks.length);
            this.bookmarks = null;
         }
         super.onDispose();
      }
   }
}
