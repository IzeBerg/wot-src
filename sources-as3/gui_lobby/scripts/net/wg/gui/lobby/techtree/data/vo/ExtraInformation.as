package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class ExtraInformation implements IValueObject
   {
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 5;
      
      private static const SOURCE_ARRAY_TYPE_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_TITLE_INDEX:uint = 1;
      
      private static const SOURCE_ARRAY_BENEFITS_HEAD_INDEX:uint = 2;
      
      private static const SOURCE_ARRAY_BENEFITS_LIST_INDEX:uint = 3;
      
      private static const SOURCE_ARRAY_PREMIUM_IGR_INDEX:uint = 4;
       
      
      public var type:String;
      
      public var title:String;
      
      public var benefitsHead:String;
      
      public var benefitsList:String;
      
      public var isPremiumIgr:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function ExtraInformation(param1:String = "", param2:String = "", param3:String = "", param4:String = "", param5:Boolean = false)
      {
         super();
         this.type = param1;
         this.title = param2;
         this.benefitsHead = param3;
         this.benefitsList = param4;
         this.isPremiumIgr = param5;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this.type = param1[SOURCE_ARRAY_TYPE_INDEX];
            this.title = param1[SOURCE_ARRAY_TITLE_INDEX];
            this.benefitsHead = param1[SOURCE_ARRAY_BENEFITS_HEAD_INDEX];
            this.benefitsList = param1[SOURCE_ARRAY_BENEFITS_LIST_INDEX];
            this.isPremiumIgr = param1[SOURCE_ARRAY_PREMIUM_IGR_INDEX];
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type != null)
         {
            this.type = param1.type;
         }
         if(param1.title != null)
         {
            this.title = param1.title;
         }
         if(param1.benefitsHead != null)
         {
            this.benefitsHead = param1.benefitsHead;
         }
         if(param1.benefitsList != null)
         {
            this.benefitsList = param1.benefitsList;
         }
         if(param1.isPremiumIgr != null)
         {
            this.isPremiumIgr = param1.isPremiumIgr;
         }
      }
      
      public function toString() : String
      {
         return "[ExtraInformation: type = " + this.type + ", title = " + this.title + " benefitsHead = " + this.benefitsHead + " benefitsList = " + this.benefitsList + " isPremiumIgr = " + this.isPremiumIgr + "]";
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
