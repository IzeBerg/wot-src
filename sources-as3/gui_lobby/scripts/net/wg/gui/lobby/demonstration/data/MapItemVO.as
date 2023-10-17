package net.wg.gui.lobby.demonstration.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapItemVO extends DAAPIDataClass
   {
      
      private static const POINTS:String = "points";
       
      
      public var id:Number = NaN;
      
      public var name:String = "";
      
      public var gameplayName:String = "";
      
      public var icon:String = "";
      
      public var points:Vector.<MapPointVO> = null;
      
      public var enabled:Boolean = false;
      
      public function MapItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == POINTS && param2 != null)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,POINTS + Errors.CANT_NULL);
            this.points = new Vector.<MapPointVO>();
            for each(_loc4_ in _loc3_)
            {
               this.points.push(new MapPointVO(_loc4_));
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MapPointVO = null;
         for each(_loc1_ in this.points)
         {
            _loc1_.dispose();
         }
         this.points.slice(0,this.points.length);
         this.points = null;
         super.onDispose();
      }
   }
}
