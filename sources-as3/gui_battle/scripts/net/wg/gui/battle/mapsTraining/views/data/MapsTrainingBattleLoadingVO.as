package net.wg.gui.battle.mapsTraining.views.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapsTrainingBattleLoadingVO extends DAAPIDataClass
   {
      
      private static const BACKGROUNDS:String = "backgrounds";
       
      
      public var backgrounds:Vector.<String>;
      
      public function MapsTrainingBattleLoadingVO(param1:Object)
      {
         this.backgrounds = new Vector.<String>(0);
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(param2 != null && param1 == BACKGROUNDS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,BACKGROUNDS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this.backgrounds.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.backgrounds != null)
         {
            this.backgrounds.splice(0,this.backgrounds.length);
            this.backgrounds = null;
         }
         super.onDispose();
      }
   }
}
