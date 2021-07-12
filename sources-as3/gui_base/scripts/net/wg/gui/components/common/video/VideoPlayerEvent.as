package net.wg.gui.components.common.video
{
   import flash.events.Event;
   
   public class VideoPlayerEvent extends Event
   {
      
      public static const META_DATA_CHANGED:String = "metaDataChanged";
      
      public static const SUBTITLE_CHANGED:String = "subtitleChanged";
      
      public static const VOLUME_CHANGED:String = "volumeChanged";
      
      public static const SEEK_START:String = "seekStart";
      
      public static const SEEK_COMPLETE:String = "seekComplete";
      
      public static const PLAYBACK_STOPPED:String = "playbackStopped";
       
      
      public function VideoPlayerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new VideoPlayerEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("VideoPlayerEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
