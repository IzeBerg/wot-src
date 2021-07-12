package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class TopPlayerAwardRendererVO extends BasePlayerAwardRendererVO
   {
      
      private static const ICONS:String = "icons";
       
      
      public var icons:DataProvider = null;
      
      public function TopPlayerAwardRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:AwardItemRendererExVO = null;
         var _loc5_:Object = null;
         if(param1 == ICONS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"icons" + Errors.CANT_NULL);
            this.icons = new DataProvider();
            _loc4_ = null;
            for each(_loc5_ in _loc3_)
            {
               _loc4_ = new AwardItemRendererExVO(_loc5_);
               this.icons.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.icons != null)
         {
            for each(_loc1_ in this.icons)
            {
               _loc1_.dispose();
            }
            this.icons.cleanUp();
            this.icons = null;
         }
         super.onDispose();
      }
   }
}
