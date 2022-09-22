package net.wg.gui.lobby.hangar.tcarousel.helper
{
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import net.wg.infrastructure.exceptions.LifecycleException;
   
   public class TankCarouselStatsFormatter
   {
      
      public static var STATE_LEVEL_BUY:String = "buy";
      
      public static var STATE_LEVEL_CRITICAL:String = "critical";
      
      public static var STATE_LEVEL_INFO:String = "info";
      
      private static var _instance:TankCarouselStatsFormatter;
       
      
      public function TankCarouselStatsFormatter()
      {
         super();
         App.utils.asserter.assertNull(_instance,"TankCarouselStatsFormatter already created.",LifecycleException);
      }
      
      public static function get instance() : TankCarouselStatsFormatter
      {
         if(_instance == null)
         {
            _instance = new TankCarouselStatsFormatter();
         }
         return _instance;
      }
      
      public function getStatColor(param1:String) : Object
      {
         var _loc15_:GlowFilter = null;
         var _loc16_:DropShadowFilter = null;
         var _loc17_:DropShadowFilter = null;
         var _loc2_:Object = {};
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 2;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Array = [];
         switch(param1)
         {
            case STATE_LEVEL_BUY:
               _loc2_.color = 15329754;
               _loc5_ = 16777150;
               _loc6_ = 0.2;
               _loc7_ = 15;
               _loc8_ = 15;
               _loc9_ = 4;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc15_ = new GlowFilter();
               _loc15_.color = _loc5_;
               _loc15_.alpha = _loc6_;
               _loc15_.blurX = _loc7_;
               _loc15_.blurY = _loc8_;
               _loc15_.strength = _loc9_;
               _loc15_.quality = _loc10_;
               _loc15_.inner = _loc11_;
               _loc15_.knockout = _loc12_;
               _loc14_.push(_loc15_);
               _loc2_.filterArray = _loc14_;
               break;
            case STATE_LEVEL_CRITICAL:
               _loc2_.color = 15400960;
               _loc3_ = 0;
               _loc4_ = 90;
               _loc5_ = 0;
               _loc6_ = 0.25;
               _loc7_ = 8;
               _loc8_ = 8;
               _loc9_ = 16;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc13_ = false;
               _loc16_ = new DropShadowFilter();
               _loc16_.distance = _loc3_;
               _loc16_.angle = _loc4_;
               _loc16_.color = _loc5_;
               _loc16_.alpha = _loc6_;
               _loc16_.blurX = _loc7_;
               _loc16_.blurY = _loc8_;
               _loc16_.strength = _loc9_;
               _loc16_.quality = _loc10_;
               _loc16_.inner = _loc11_;
               _loc16_.knockout = _loc12_;
               _loc16_.hideObject = _loc13_;
               _loc14_.push(_loc16_);
               _loc2_.filterArray = _loc14_;
               break;
            case STATE_LEVEL_INFO:
            default:
               _loc2_.color = 13617064;
               _loc3_ = 0;
               _loc4_ = 90;
               _loc5_ = 0;
               _loc6_ = 0.25;
               _loc7_ = 8;
               _loc8_ = 8;
               _loc9_ = 16;
               _loc10_ = 2;
               _loc11_ = false;
               _loc12_ = false;
               _loc13_ = false;
               _loc17_ = new DropShadowFilter();
               _loc17_.distance = _loc3_;
               _loc17_.angle = _loc4_;
               _loc17_.color = _loc5_;
               _loc17_.alpha = _loc6_;
               _loc17_.blurX = _loc7_;
               _loc17_.blurY = _loc8_;
               _loc17_.strength = _loc9_;
               _loc17_.quality = _loc10_;
               _loc17_.inner = _loc11_;
               _loc17_.knockout = _loc12_;
               _loc17_.hideObject = _loc13_;
               _loc14_.push(_loc17_);
               _loc2_.filterArray = _loc14_;
         }
         return _loc2_;
      }
   }
}
