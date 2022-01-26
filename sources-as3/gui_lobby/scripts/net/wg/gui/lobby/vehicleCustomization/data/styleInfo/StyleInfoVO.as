package net.wg.gui.lobby.vehicleCustomization.data.styleInfo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StyleInfoVO extends DAAPIDataClass
   {
      
      private static const STYLE_PARAMS:String = "styleParams";
       
      
      public var styleName:String = "";
      
      public var styleInfo:String = "";
      
      public var styleInfoBig:String = "";
      
      public var suitableBlock:String = "";
      
      public var styleParams:Vector.<ParamRevdererVO> = null;
      
      public function StyleInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param2 != null)
         {
            if(param1 == STYLE_PARAMS && param2 != null)
            {
               this.styleParams = new Vector.<ParamRevdererVO>();
               for each(_loc3_ in param2)
               {
                  this.styleParams.push(new ParamRevdererVO(_loc3_));
               }
               return false;
            }
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.styleParams)
         {
            for each(_loc1_ in this.styleParams)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this.styleParams.splice(0,this.styleParams.length);
            this.styleParams = null;
         }
         super.onDispose();
      }
   }
}
