package net.wg.gui.lobby.badges.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BadgeSuffixVO extends DAAPIDataClass
   {
      
      private static const ITEMS:String = "items";
       
      
      public var checkboxLabel:String = "";
      
      public var checkboxTooltip:String = "";
      
      public var checkboxSelected:Boolean = false;
      
      public var selectedItemIdx:uint = 0;
      
      public var items:Vector.<BadgeSuffixItemVO> = null;
      
      public function BadgeSuffixVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:BadgeSuffixItemVO = null;
         var _loc5_:Object = null;
         if(param1 == ITEMS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            this.items = new Vector.<BadgeSuffixItemVO>(0);
            for each(_loc5_ in _loc3_)
            {
               _loc4_ = new BadgeSuffixItemVO(_loc5_);
               this.items.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.items != null)
         {
            for each(_loc1_ in this.items)
            {
               _loc1_.dispose();
            }
            this.items.splice(0,this.items.length);
            this.items = null;
         }
         super.onDispose();
      }
   }
}
