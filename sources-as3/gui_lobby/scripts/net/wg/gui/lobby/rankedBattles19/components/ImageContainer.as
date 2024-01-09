package net.wg.gui.lobby.rankedBattles19.components
{
   import flash.geom.Point;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ImageContainer extends UIComponentEx
   {
       
      
      public var img:IImage = null;
      
      private var _source:String = null;
      
      private var _imgPoint:Point = null;
      
      public function ImageContainer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._source) && isInvalid(InvalidationType.DATA))
         {
            this.img.source = this._source;
         }
         if(this._imgPoint != null && isInvalid(InvalidationType.LAYOUT))
         {
            this.img.x = this._imgPoint.x;
            this.img.y = this._imgPoint.y;
         }
      }
      
      override protected function onDispose() : void
      {
         this.img.dispose();
         this.img = null;
         super.onDispose();
      }
      
      public function setImgPoint(param1:Point) : void
      {
         if(param1 != null && this._imgPoint != param1)
         {
            this._imgPoint = param1;
            invalidateLayout();
         }
      }
      
      public function setSource(param1:String) : void
      {
         if(StringUtils.isNotEmpty(param1) && this._source != param1)
         {
            this._source = param1;
            invalidateData();
         }
      }
   }
}
