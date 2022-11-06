package net.wg.gui.lobby.badges.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class BadgesGroupVO extends DAAPIDataClass
   {
      
      public static const BADGES_DATA_FIELD:String = "badgesData";
       
      
      public var title:String = "";
      
      private var _badgesData:DataProvider = null;
      
      public function BadgesGroupVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == BADGES_DATA_FIELD)
         {
            this._badgesData = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            for each(_loc4_ in _loc3_)
            {
               this._badgesData.push(new BadgeVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._badgesData)
         {
            _loc1_.dispose();
         }
         this._badgesData.cleanUp();
         this._badgesData = null;
         super.onDispose();
      }
      
      public function get badgesData() : DataProvider
      {
         return this._badgesData;
      }
   }
}
